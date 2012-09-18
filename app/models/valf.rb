class Valf < ActiveRecord::Base
  belongs_to :sprinkler
  attr_accessible :identifier, :port_index, :irrigation_mode, :valf_type
  classy_enum_attr :irrigation_mode, :allow_nil => false
  classy_enum_attr :valf_type, :allow_nul => false
  has_many :valf_plans, dependent: :destroy
  
  validates :identifier, presence: true
  validates :port_index, presence: true, :numericality => {:only_integer => true, :greater_than_or_equal_to => 0}, :uniqueness => { :scope => :sprinkler_id }

    
  default_scope order: 'port_index'

  def to_s
    if valf_type.to_s.blank?
      port_index.to_s
    else
      port_index.to_s + " " + valf_type.text
    end
  end
end
