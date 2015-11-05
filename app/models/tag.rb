class Tag < ActiveRecord::Base
  scope :ordered, -> { order('name ASC') }
  scope :excluding, -> (tag_ids=[]) { where.not id: tag_ids if tag_ids.any? }
  scope :search, -> (term=nil) { 
    where 'name LIKE :term', { term: "%#{term}%" } if term.present?
  }
end
