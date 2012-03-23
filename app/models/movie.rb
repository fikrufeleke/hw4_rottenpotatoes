class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.find_in_mvdb(name)
   find(:all, :conditions => { :director => name})
  end
end
