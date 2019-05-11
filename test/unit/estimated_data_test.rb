require "test/unit"
require "active_model"
require "../../app/models/estimated_data"
require "date"

=begin
  Az EstimatedData modell osztaly unit testjei
=end
class EstimatedDataTest < Test::Unit::TestCase

    setup do
        $tested=EstimatedData.new(DateTime.now.to_date,1,2,3)
    end

    def test_data_item_not_null
        assert_not_equal $tested, nil
    end

    def test_data_item_persisted
        assert_equal $tested.persisted?, false
    end

    def test_estimated_data_variables_types
        assert $tested.date.kind_of?(Date)
        assert $tested.estimatedSum.kind_of?(Integer)
        assert $tested.factSum.kind_of?(Integer)
        assert $tested.leftSum.kind_of?(Integer)
    end

    def test_estimated_data_happy_path_tests
        assert_equal $tested.date, DateTime.now.to_date
        assert_equal $tested.estimatedSum, 1
        assert_equal $tested.factSum, 2
        assert_equal $tested.leftSum, 3
    end

    def test_estimated_data_bad_path_tests
        assert_not_equal $tested.date, DateTime.now.to_date+1
        assert_not_equal $tested.estimatedSum, 2
        assert_not_equal $tested.factSum, 3
        assert_not_equal $tested.leftSum, 4
    end

    def test_estimated_data_change_tests
        $tested.date = DateTime.now.to_date+1
        assert_not_equal $tested.date, DateTime.now.to_date
        assert_equal $tested.date, DateTime.now.to_date+1
        $tested.estimatedSum = 2
        assert_not_equal $tested.estimatedSum, 1
        assert_equal $tested.estimatedSum, 2
        $tested.leftSum = 4
        assert_not_equal $tested.leftSum, 2
        assert_equal $tested.leftSum, 4
        $tested.factSum = 2
        assert_not_equal $tested.factSum, 3
        assert_equal $tested.factSum, 2
    end

end