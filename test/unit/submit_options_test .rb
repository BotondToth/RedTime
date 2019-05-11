require "test/unit"
require "active_model"
require "../../app/models/submit_options"
require "date"

=begin
  A SubmitOptions modell osztaly unit testjei
=end
class SubmitOptionsTest < Test::Unit::TestCase

    setup do
        $tested=SubmitOptions.new(["Teszt1", "Teszt2"],["1","2", "3"],["name1", "name2"])
    end

    def test_submit_options_not_null
        assert_not_equal $tested, nil
    end

    def test_submit_options_persisted
        assert_equal $tested.persisted?, false
    end

    def test_submit_options_projects_happy_path
        assert_equal $tested.projects.size, 2
        assert_equal $tested.projects, ["Teszt1", "Teszt2"]
    end

    def test_submit_options_sprints_happy_path
        assert_equal $tested.sprints.size, 3
        assert_equal $tested.sprints, ["1", "2", "3"]
    end

    def test_submit_options_names_happy_path
        assert_equal $tested.names.size, 2
        assert_equal $tested.names, ["name1", "name2"]
    end

    def test_submit_options_projects_bad_path
        assert_not_equal $tested.projects.size, 1
        assert_not_equal $tested.projects, ["Teszt", "Teszt2"]
    end

    def test_submit_options_sprints_bad_path
        assert_not_equal $tested.sprints.size, 5
        assert_not_equal $tested.sprints, ["1", "2", "0"]
    end

    def test_submit_options_names_bad_path
        assert_not_equal $tested.names.size, 1
        assert_not_equal $tested.names, ["name4", "name2"]
    end


end