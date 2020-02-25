module Rates
  class CustomUpdate
    include Interactor::Organizer

    organize SetCustom, AddToLog, SendNotification
  end
end
