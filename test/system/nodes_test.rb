require "application_system_test_case"

class NodesTest < ApplicationSystemTestCase
  setup do
    @node = nodes(:node_1_1)
  end

  test "visiting the index" do
    visit organization_node_url(@node.organization, @node)
    assert_selector "h1", text: "Children"
  end

  test "creating a Node" do
    visit organization_node_url(@node.organization, @node)
    click_on "New Node"

    fill_in "Name", with: @node.name
    click_on "Create Node"

    assert_text "Node was successfully created"
    click_on "Back"
  end

  test "updating a Node" do
    visit organization_node_url(@node.organization, @node)
    click_on "Edit", match: :first

    fill_in "Name", with: @node.name
    click_on "Update Node"

    assert_text "Node was successfully updated"
    click_on "Back"
  end

  test "destroying a Node" do
    visit organization_node_url(@node.organization, @node)
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Node was successfully destroyed"
  end
end
