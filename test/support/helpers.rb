def sample_image(path=nil)
  File.open(sample_image_path(path))
end

def sample_image_path(path=nil)
  path ||= "1.jpg"
  File.expand_path("../files/#{path}", __FILE__)
end

def setup_action_controller_behaviour(controller_class)
  @routes = Spree::Core::Engine.routes
  @controller = controller_class.new
end

def stub_authorization!
  setup { Spree::Ability.register_ability(AuthorizationHelpers::Request::SuperAbility) }
  teardown { Spree::Ability.remove_ability(AuthorizationHelpers::Request::SuperAbility) }
end

module AuthorizationHelpers
  module Controller
    def stub_authorization!
      let(:ability_user) { stub_model(Spree::LegacyUser) }

      before do
        controller.stub(:try_spree_current_user => ability_user)
        controller.should_receive(:authorize!).any_number_of_times.and_return(true)
      end
    end
  end

  module Request
    class SuperAbility
      include CanCan::Ability

      def initialize(user)
        # allow anyone to perform index on Order
        can :manage, :all
      end
    end
  end
end