class Valf < ActiveRecord::Base
  belongs_to :sprinkler
  attr_accessible :identifier, :port_index
  
  validates :identifier, presence: true
  validates :port_index, presence: true, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}, :uniqueness => { :scope => :sprinkler_id }

  default_scope order: 'port_index'

end
