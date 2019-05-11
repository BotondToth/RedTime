require "test/unit"
require "active_model"
require "../../app/models/data_item"
require "date"

class DataItemTest < Test::Unit::TestCase
    
    setup do
        $tested=DataItem.new("Bela",DateTime.now.to_date,[3,2,1])
    end

    def test_data_item_not_null
        assert_not_equal $tested, nil
    end

    def test_data_item_persisted
        assert_equal $tested.persisted?, false
    end

    def test_data_item_name_happy_path
        assert_equal $tested.user, 'Bela'
    end

    def test_data_item_name_bad_path
        assert_not_equal $tested.user, 'valaki'
    end

    def test_data_item_time_happy_path
        assert_equal $tested.date, DateTime.now.to_date
    end

    def test_data_item_time_bad_path
        assert_not_equal $tested.date, DateTime.now.to_date+1
    end

    def test_data_item_sprints_happy_path
        assert_equal $tested.sprints, [3,2,1]
    end

    def test_data_item_sprints_bad_path
        assert_not_equal $tested.sprints, [1,2,3]
    end

    def test_data_item_user_change
        $tested.user = "Gyula"
        assert_not_equal $tested.user, "Bela"
        assert_equal $tested.user, "Gyula"
    end

    def test_data_item_date_change
        $tested.date = DateTime.now.to_date+1
        assert_not_equal $tested.date, DateTime.now.to_date
        assert_equal $tested.date, DateTime.now.to_date+1
    end

    def test_data_item_sprints_change
        $tested.sprints = []
        assert_not_equal $tested.sprints, [3, 2, 1]
        assert_equal $tested.sprints, []
    end
end