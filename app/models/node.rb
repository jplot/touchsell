class Node < ApplicationRecord
  belongs_to :record, polymorphic: true
  belongs_to :parent, class_name: 'Node', foreign_key: :node_id, inverse_of: :children, optional: true

  has_many :children, class_name: 'Node', dependent: :destroy

  validates :name, presence: true
  validates :primary, if: -> { primary }, uniqueness: { scope: %i[record_type record_id] }

  scope :primary, -> { where(primary: true) }
  scope :main, -> { where(parent: nil) }

  after_initialize if: -> { new_record? && !record && parent } do
    initialize_record
  end

  before_validation on: :destroy, if: -> { primary } do
    errors.add(:record, :detached)
  end

  before_validation on: :update, if: -> { primary } do
    errors.add(:name, :changed)
  end

  def node_id=(value)
    super
    initialize_record
    node_id
  end

  def parent=(value)
    super
    initialize_record
    parent
  end

  def organization
    case record
    when Organization
      record
    else
      record.organization
    end
  end

  private

  def initialize_record
    self.record = case parent.record
                  when Organization
                    parent
                  else
                    parent.record
                  end
  end
end
