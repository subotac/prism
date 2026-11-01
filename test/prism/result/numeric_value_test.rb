# frozen_string_literal: true

require_relative "../test_helper"

module Prism
  class NumericValueTest < TestCase
    def test_numeric_value
      assert_equal 123, Prism.parse_statement("123").value
      assert_equal 123, Prism.parse_statement("1_23").value
      assert_equal 3.14, Prism.parse_statement("3.14").value
      assert_equal 3.14, Prism.parse_statement("3.1_4").value
      assert_equal 42i, Prism.parse_statement("42i").value
      assert_equal 42i, Prism.parse_statement("4_2i").value
      assert_equal 42.1ri, Prism.parse_statement("42.1ri").value
      assert_equal 42.1ri, Prism.parse_statement("42.1_0ri").value
      assert_equal 3.14i, Prism.parse_statement("3.14i").value
      assert_equal 3.14i, Prism.parse_statement("3.1_4i").value
      assert_equal 42r, Prism.parse_statement("42r").value
      assert_equal 42r, Prism.parse_statement("4_2r").value
      assert_equal 0.5r, Prism.parse_statement("0.5r").value
      assert_equal 0.5r, Prism.parse_statement("0.5_0r").value
      assert_equal 42ri, Prism.parse_statement("42ri").value
      assert_equal 42ri, Prism.parse_statement("4_2ri").value
      assert_equal 0.5ri, Prism.parse_statement("0.5ri").value
      assert_equal 0.5ri, Prism.parse_statement("0.5_0ri").value
      assert_equal 0xFFr, Prism.parse_statement("0xFFr").value
      assert_equal 0xFFr, Prism.parse_statement("0xF_Fr").value
      assert_equal 0xFFri, Prism.parse_statement("0xFFri").value
      assert_equal 0xFFri, Prism.parse_statement("0xF_Fri").value
    end

    def test_integer_values_after_syntax_errors
      {
        "1 2 3" => [1, 2, 3],
        "0 1 2" => [0, 1, 2],
        "1 22_2 333" => [1, 222, 333],
        "1 4294967296 2" => [1, 4294967296, 2]
      }.each do |source, expected|
        assert_equal expected, Prism.parse(source).value.statements.body.map(&:value), source
      end
    end

    def test_imaginary_values_after_syntax_errors
      {
        "1i 2i 3i" => [1i, 2i, 3i],
        "1i 0x2i 3i" => [1i, 2i, 3i]
      }.each do |source, expected|
        assert_equal expected, Prism.parse(source).value.statements.body.map(&:value), source
      end
    end
  end
end
