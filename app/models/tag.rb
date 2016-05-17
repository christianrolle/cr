class Tag < ActiveRecord::Base

  before_validation :set_slug

  validates :name, presence: true, uniqueness: true, length: { in: 2..200 }
  validates :slug, presence: true, uniqueness: true

  scope :ordered, -> { order('name ASC') }
  scope :excluding, ->(tag_ids=[]) { where.not id: tag_ids if tag_ids.any? }
  scope :search, ->(term=nil) { 
    where 'name LIKE :term', { term: "%#{term}%" } if term.present?
  }
  scope :slugged, ->(slug) { where(table_name => { slug: slug }) }

  private

  def set_slug
    self.slug ||= name.parameterize if name.present?
  end

end
