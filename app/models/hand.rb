class Hand < ApplicationRecord

  def set_hands(hands)
    self.content = hands
    self.save!
  end


end
