class Category < ApplicationRecord
  has_many :products
  has_ancestry 

  def self.buildArray_of_family_from_parent(parent_id)
    parent_ids          = Category.where(id: parent_id).ids
    children_ids        = Category.find(parent_id).children.ids.flatten
    grand_children_ids  = Category.find(parent_id).children.map{|child| child.children.ids}.flatten
    return parent_ids.push(children_ids).push(grand_children_ids).flatten!
  end
end
