class AgentController < ApplicationController
  def metadata_adapter
    Valkyrie.config.metadata_adapter
  end

  def index
    @agents = metadata_adapter.query_service.find_all_of_model(model: Agent)
  end

  def show
    @model = metadata_adapter.query_service.find_by(id: params[:id])
  end

  def new
    @model = Agent.new
  end

  def edit
    @model = metadata_adapter.query_service.find_by(id: Valkyrie::ID.new(params[:id]))
  end

  def create
    @agent = Agent.new(require_params.to_h)
    @agent = metadata_adapter.persister.save(resource: @agent);
    if @agent
      redirect_to edit_agent_path @agent, notice: 'Agent was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @agent = metadata_adapter.query_service.find_by(id: params[:id])
    require_params.to_h.map do |key, value|
      @agent.send("#{key}=", value)
    end
    if metadata_adapter.persister.save(resource: @agent)
      redirect_to @agent, notice: 'Agent was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @model.destroy
    redirect_to index_path
  end

  def _prefixes
    # This allows us to use the attributes templates in base, while prefering
    @_prefixes ||= super + ['base']
  end

  private

  def require_params
    params.require(:agent).permit(:label,
                                  :alternateLabel,
                                  :orcid,
                                  :identifier,
                                  :type)
  end
end