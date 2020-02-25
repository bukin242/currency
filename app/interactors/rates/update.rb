module Rates
  class Update
    include Interactor::Organizer

    organize Parse, AddToLog, SendNotification
  end
end
