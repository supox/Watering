class MainValveTiming < ClassyEnum::Base
end

class MainValveTiming::Delayed < MainValveTiming
  def sign
    (-1)
  end
end

class MainValveTiming::Advanced < MainValveTiming
  def sign
    (1)
  end
end

class MainValveTiming::Simultaneous < MainValveTiming
  def sign
    0
  end

end
