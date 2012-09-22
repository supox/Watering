class ValfType < ClassyEnum::Base
  def short
    "U"
  end
end

class ValfType::Normal < ValfType
  def short
    "N"
  end
end

class ValfType::Fertilization < ValfType
  def short
    "F"
  end
end
