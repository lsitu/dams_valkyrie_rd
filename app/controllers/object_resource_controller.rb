class ObjectResourceController < ApplicationController
  def resource_class
    ObjectResource
  end

  def metadata_adapter
    Valkyrie.config.metadata_adapter
  end

  def index
    @model = metadata_adapter.query_service.find_all
  end

  def show
    @model = metadata_adapter.query_service.find_by(id: Valkyrie::ID.new(params[:id]))
    @collections = metadata_adapter.query_service.find_all_of_model(model: Collection)
    @agents = metadata_adapter.query_service.find_all_of_model(model: Agent)
    @components = metadata_adapter.query_service.find_all_of_model(model: ObjectResource)
  end

  def new
    @collections = metadata_adapter.query_service.find_all_of_model(model: Collection).map { |rec| [rec.title.first, rec.id] }
    @agents = metadata_adapter.query_service.find_all_of_model(model: Agent).map { |rec| [rec.label.first, rec.id] }
    @components = metadata_adapter.query_service.find_all_of_model(model: ObjectResource).map { |rec| [rec.title.first, rec.id] }
    @model = ObjectResource.new
  end

  def edit
    @collections = metadata_adapter.query_service.find_all_of_model(model: Collection).map { |rec| [rec.title.first, rec.id] }
    @agents = metadata_adapter.query_service.find_all_of_model(model: Agent).map { |rec| [rec.label.first, rec.id] }
    @components = metadata_adapter.query_service.find_all_of_model(model: ObjectResource)
      .reject { |rec| rec.id.to_s == @model.id.to_s }
      .map { |rec| [rec.title.first, rec.id] }
    @model = metadata_adapter.query_service.find_by(id: Valkyrie::ID.new(params[:id]))
  end

  def create
    @model = ObjectResource.new(require_params.to_h)
    @model = metadata_adapter.persister.save(resource: @model);
    if @model
      redirect_to @model, notice: 'Work was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @model = metadata_adapter.query_service.find_by(id: params[:id])
    require_params.to_h.map do |key, value|
      @model.send("#{key}=", value)
    end
    if metadata_adapter.persister.save(resource: @model)
      redirect_to @model, notice: 'Object was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @model = metadata_adapter.query_service.find_by(id: params[:id])

    metadata_adapter.persister.delete(resource: @model)
    flash[:alert] = "Deleted #{@model}"
    redirect_to object_resources_path
  end

  def _prefixes
    # This allows us to use the attributes templates in base, while prefering
    @_prefixes ||= super + ['base']
  end

  def require_params
    params.require(:object_resource)
          .permit(:title,
                  :date_created,
                  creator_ids: [],
                  member_of_collection_ids: [],
                  member_ids: [])
  end
end
