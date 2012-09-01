class MainValveTiming < ClassyEnum::Base
end

class MainValveTiming::Delayed < MainValveTiming
end

class MainValveTiming::Advanced < MainValveTiming
end

class MainValveTiming::Simultaneous < MainValveTiming
end
