require "test/unit"
require "active_model"
require "../../app/models/stat_item"
require "date"

=begin
  A StatItem modell osztaly unit testjei
=end
class StatItemTest < Test::Unit::TestCase
    
    setup do
        $tested=StatItem.new(1, "sprint", 100)
    end

    def test_data_item_not_null
        assert_not_equal $tested, nil
    end

    def test_data_item_persisted
        assert_equal $tested.persisted?, false
    end

    def test_stat_item_sprint_happy_path
        assert_equal $tested.sprint, 1
    end

    def test_stat_item_sprint_bad_path
        assert_not_equal $tested.sprint, 2
    end

    def test_stat_item_type_happy_path
        assert_equal $tested.type, "sprint"
    end

    def test_stat_item_type_bad_path
        assert_not_equal $tested.type, "nemsprint"
    end

    def test_stat_item_remaining_hours_happy_path
        assert_equal $tested.remaining_hours, 100
    end

    def test_stat_item_remaining_hours_bad_path
        assert_not_equal $tested.remaining_hours, 10
    end

    def test_stat_item_sprint_change
        $tested.sprint = 2
        assert_not_equal $tested.sprint, 1
        assert_equal $tested.sprint, 2
    end

    def test_stat_item_type_change
        $tested.type = "sprint2"
        assert_not_equal $tested.type, "sprint"
        assert_equal $tested.type, "sprint2"
    end

    def test_stat_item_hours_change
        $tested.remaining_hours = 10
        assert_not_equal $tested.remaining_hours, 100
        assert_equal $tested.remaining_hours, 10
    end

end