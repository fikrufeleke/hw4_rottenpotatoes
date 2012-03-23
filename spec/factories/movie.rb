require 'spec_helper'

factorymovie.define do
  factory :movie do
    title 'A Fake Title' # default values
    rating 'PG'
    director 'mao'
    release_date { 10.years.ago }
  end
end
