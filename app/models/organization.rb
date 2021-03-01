class Organization < ApplicationRecord
  has_many :nodes, as: :record, dependent: :destroy
  has_one :primary_node, -> { primary }, as: :record, class_name: 'Node'

  validates :name, presence: true

  after_initialize do
    initialize_primary_node
  end

  after_update_commit do
    primary_node.save(context: :organization)
  end

  def name=(value)
    super
    initialize_primary_node
    name
  end

  private

  def initialize_primary_node
    if new_record? && !primary_node
      self.primary_node = nodes.build(primary: true)
    end

    primary_node.name = name
  end
end
