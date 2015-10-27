class Tag < ActiveRecord::Base
  def self.search(term=nil)
    return scoped if term.blank?
    where 'name LIKE :term', { term: "%#{term}%" }
  end
end
