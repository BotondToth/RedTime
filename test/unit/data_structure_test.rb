require "test/unit"
require "active_model"
require "../../app/models/data_structure"

=begin
  A DataStructure modell osztaly unit testjei
=end
class DataStructureTest < Test::Unit::TestCase

    setup do
        $tested=DataStructure.new(["dataItem1", "dataItem2"], ["1. sprint", "2. sprint", "3. sprint"], "Teszt")
    end

    def test_data_structure_not_null
        assert_not_equal $tested, nil
    end

    def test_data_structure_persisted
        assert_equal $tested.persisted?, false
    end

    def test_data_structure_items_is_array
        assert $tested.dataItems.kind_of?(Array)
    end

    def test_data_structure_sprints_is_array
        assert $tested.namesOfSprints.kind_of?(Array)
    end

    def test_data_structure_projectName_is_string
        assert $tested.projectName.kind_of?(String)
    end

    def test_data_structure_items_happy_path
        assert_equal $tested.dataItems, ["dataItem1", "dataItem2"]
    end

    def test_data_structure_items_bad_path
        assert_not_equal $tested.dataItems, ["dataItem1", "dataItem2", "dummyItem"]
    end

    def test_data_structure_sprints_happy_path
        assert_equal $tested.namesOfSprints.size, 3
        assert_equal $tested.namesOfSprints, ["1. sprint", "2. sprint", "3. sprint"]
    end

    def test_data_structure_sprints_bad_path
        assert_not_equal $tested.namesOfSprints.size, 2
        assert_not_equal $tested.namesOfSprints, ["2. sprint", "3. sprint"]
    end

    def test_data_structure_projectName_happy_path
        assert_equal $tested.projectName, "Teszt"
    end

end