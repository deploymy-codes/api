RSpec::Matchers.define :be_paginated do |expected|
  match do |actual|
    actual.headers['X-LIMIT'] == 100 &&
      actual.headers['X-TOTAL-COUNT'] != '' &&
      actual.headers['Link'] != nil
  end
end
