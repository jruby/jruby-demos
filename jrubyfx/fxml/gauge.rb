require 'jrubyfx'
fxml_root File.dirname(__FILE__)

class GaugeApp < JRubyFX::Application
    def start(stage)
        with(stage, title: "Gauge Demo", width: 800, height: 600) do
          fxml GaugeController
          show
        end
    end
end

class GaugeController
  include JRubyFX::Controller
  fxml "gauge.fxml"

  def initialize(*)
    @slider.value_property.add_listener do |slider|
      @gauge.gauge.value  = slider.value
    end
  end
end

GaugeApp.launch
