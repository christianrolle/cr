class Tag < ActiveRecord::Base
  scope :ordered, -> { order('name ASC') }

  def self.search(term=nil)
    return scoped if term.blank?
    where 'name LIKE :term', { term: "%#{term}%" }
  end
end
