context "when the node to delete is the root" do
  it "deletes the root" do
    tree.delete(5)

    expect(tree.root).to eq(nil)
  end
end

context "when the node to delete is a leaf" do #hier
  it "deletes the leaf" do
    tree.delete(1)
    expect(tree.node_exists?(1)).to eq(false)
  end
end

context "when the node to delete has only one child" do
  it "deletes the node" do
    tree.delete(8)

    expect(tree.node_exists?(8)).to eq(false)
  end

  it "does not delete its children" do
    tree.pretty_print
    tree.delete(2)
    tree.pretty_print
    expect(tree.node_exists?(1)).to eq(true)
  end

  it "links its children to the correct node" do
    tree.delete(2)
    orphaned_child_value = 1

    expect(tree.root.left_children.left_children.value).to eq(1)
  end
end

context "when the node to delete has 2 children" do
  it "deletes the node" do
    tree.delete(3)

    expect(tree.node_exists?(3)).to eq(false)
  end

  it "does not delete its children" do
    tree.delete(3)

    expect(tree.node_exists?(4)).to eq(true)
    expect(tree.node_exists?(2)).to eq(true)
    expect(tree.node_exists?(1)).to eq(true)
  end
end
end