class CollectionController < ApplicationController
  def metadata_adapter
    Valkyrie.config.metadata_adapter
  end

  def index
  end

  def show
    @model = metadata_adapter.query_service.find_by(id: params[:id])
    @collections = metadata_adapter.query_service.find_all_of_model(model: Collection)
    @agents = metadata_adapter.query_service.find_all_of_model(model: Agent)
  end

  def edit
    @model = metadata_adapter.query_service.find_by(id: params[:id])
    @collections = metadata_adapter.query_service.find_all_of_model(model: Collection)
      .reject { |rec| rec.id.to_s == @model.id.to_s }
      .map { |rec| [rec.title.first, rec.id] }
    @agents = metadata_adapter.query_service.find_all_of_model(model: Agent).map { |rec| [rec.label.first, rec.id] }
  end

  def new
    @collections = metadata_adapter.query_service.find_all_of_model(model: Collection).map { |rec| [rec.title.first, rec.id] }
    @agents = metadata_adapter.query_service.find_all_of_model(model: Agent).map { |rec| [rec.label.first, rec.id] }
    @model = Collection.new
  end

  def create
    @collection = Collection.new(require_params.to_h)
    @collection = metadata_adapter.persister.save(resource: @collection);
    if @collection
      redirect_to @collection, notice: 'Collection was successfully created.'
    else
      @collections = metadata_adapter.query_service.find_all_of_model(model: Collection)
      @agents = metadata_adapter.query_service.find_all_of_model(model: Agent)
      render action: 'new'
    end
  end

  def update
    @collection = metadata_adapter.query_service.find_by(id: params[:id])
    require_params.to_h.map do |key, value|
      @collection.send("#{key}=", value)
    end
    if metadata_adapter.persister.save(resource: @collection)
      redirect_to @collection, notice: 'Collection was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
  end

  def _prefixes
    # This allows us to use the attributes templates in base, while prefering
    @_prefixes ||= super + ['base']
  end

  def require_params
    params.require(:collection)
          .permit(:title,
                  :description,
                  :date_created,
                  publisher_ids: [],
                  member_collection_ids: [])
  end
end
