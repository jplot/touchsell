class NodesController < ApplicationController
  before_action :set_organization
  before_action :set_parent, only: %i[new create]
  before_action :set_node, only: %i[show edit update destroy]

  def index
    @nodes = Node.all
  end

  def show
  end

  def new
    @node = @parent.children.build
  end

  def edit
  end

  def create
    @node = @parent.children.build(node_params)

    if @node.save
      redirect_to @node, notice: 'Node was successfully created.'
    else
      render :new
    end
  end

  def update
    if @node.update(node_params)
      redirect_to @node, notice: 'Node was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @node.destroy

    redirect_to @node.parent ? organization_node_path(@node.organization, @node.parent) : organization_nodes_url(@organization), notice: 'Node was successfully destroyed.'
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_parent
    node_params = params.key?(:node) ? params[:node] : params

    @parent = Node.find(node_params[:node_id])

    raise ActiveRecord::RecordNotFound unless @parent.organization == @organization
  end

  def set_node
    @node = Node.find(params[:id])

    raise ActiveRecord::RecordNotFound unless @node.organization == @organization
  end

  def node_params
    params.require(:node).permit(:organization_id, :node_id, :name)
  end
end
