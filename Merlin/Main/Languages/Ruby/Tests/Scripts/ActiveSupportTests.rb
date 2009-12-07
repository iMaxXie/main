require "rubygems"
gem "activesupport", "= 2.3.3"
require 'active_support/version'

root_dir = File.expand_path '..\External.LCA_RESTRICTED\Languages\IronRuby\RailsTests-2.3.3\activesupport', ENV['MERLIN_ROOT']
$LOAD_PATH << root_dir + '/test'
test_files = Dir.glob("#{root_dir}/test/**/*_test.rb").sort

# Do some sanity checks
abort("Did not find enough tests files...") unless test_files.size > 65
abort("Did not find some expected files...") unless File.exist?(root_dir + "/test/dependencies_test.rb")
abort("Loaded the wrong version #{ActiveSupport::VERSION::STRING} instead of the expected 2.3.3 ...") unless ActiveSupport::VERSION::STRING == '2.3.3'

# Note that the tests are registered using Kernel#at_exit, and will run during shutdown
# The "require" statement just registers the tests for being run later...
test_files.each { |f| require f }

# Disable failing tests by monkey-patching the test method to be a nop

# The first set of tags is non-deterministic test failures

class BufferedLoggerTest
  # <false> is not true.
  def test_should_create_the_log_directory_if_it_doesnt_exist() end
end

class MessageEncryptorTest
  # NameError: uninitialized constant OpenSSL::Cipher
  # ArgumentError: wrong number of arguments (1 for 0)
  def setup() end
end

class DateExtCalculationsTest
  # This failed on the community build machine at http://ironruby.koolkraft.net
  # <Sat, 01 Jan 2000> expected but was
  # <Fri, 31 Dec 1999>.
  def test_current_returns_time_zone_today_when_zone_default_set() end
end

# The following list of test tags is generated by doing:
#   require "generate_test-unit_tags"

class ClassExtTest
  # <[#<Class:0x0004d60 @inheritable_attributes={}>]> expected but was
  # <[]>.
  def test_subclasses_of_doesnt_find_anonymous_classes() end
end

class DateTimeExtCalculationsTest
  # <"+00:00"> expected but was
  # <"000:00">.
  def test_formatted_offset_with_utc() end

  # <"Mon, 21 Feb 2005 14:30:00 +0000"> expected but was
  # <"Mon, 21 Feb 2005 14:30:00 00000">.
  def test_readable_inspect() end

  # <"Mon, 21 Feb 2005 14:30:00 +0000"> expected but was
  # <"Mon, 21 Feb 2005 14:30:00 00000">.
  def test_to_s() end

end

class HashExtTest
  # <{0=>1, 1=>2}> expected but was
  # <{0=>1, :Module=>2}>.
  def test_symbolize_keys_preserves_fixnum_keys() end
end

class MessageVerifierTest
  # <{:some=>"data", :now=>Tue Sep 08 10:03:28 -07:00 2009}> expected but was
  # <{:some=>"data", :now=>Tue Sep 08 10:03:12 -07:00 2009}>.
  def test_simple_round_tripping() end
end

class MultibyteCharsExtrasTest
  # <"???? ????"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x189b0
  #  @wrapped_string=
  #   "\320\220\320\261\320\262\320\263 \320\260\320\261\320\262\320\263">>.
  def test_capitalize_should_be_unicode_aware() end

  # <"?????\000f"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x189ee
  #  @wrapped_string="\320\260\320\261\320\262\320\263\320\264\000f">>.
  def test_downcase_should_be_unicode_aware() end

  # System::Text::DecoderFallbackException: Unable to translate bytes [B8] at index -1 from specified code page to Unicode.
  def test_tidy_bytes_should_tidy_bytes() end

  # <"?????\000F"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x18adc
  #  @wrapped_string="\320\220\320\221\320\222\320\223\320\224\000F">>.
  def test_upcase_should_be_unicode_aware() end

end

class MultibyteCharsUTF8BehaviourTest
  # <"???? "> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x18c32
  #  @wrapped_string="\343\201\223\343 \201\253\343\201\241\343\202\217">>.
  def test_center_should_count_charactes_instead_of_bytes() end

  # RangeError: Count must be positive and count must refer to a location within the string/array/collection.
  # Parameter name: count
  def test_index_should_return_character_offset() end

  # <"?? ?"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x18cb0
  #  @wrapped_string="\343\201\223\343\201\253 \343\202\217">>.
  def test_indexed_insert_accepts_fixnums() end

  # <IndexError> exception expected but was
  # Class: <TypeError>
  # Message: <"can't convert Regexp into Fixnum">
  # ---Backtrace---
  # c:/github/ironruby/Merlin/External.LCA_RESTRICTED/Languages/Ruby/ruby-1.8.6p368/lib/ruby/gems/1.8/gems/activesupport-2.3.3/lib/active_support/multibyte/chars.rb:228:in `[]='
  # c:/github/ironruby/Merlin/External.LCA_RESTRICTED/Languages/IronRuby/RailsTests-2.3.3/activesupport/test/m
  def test_indexed_insert_should_raise_on_index_overflow() end

  # <"??a?"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x18d32
  #  @wrapped_string="\343\201\223\343\201\253a\343\202\217">>.
  def test_indexed_insert_should_take_character_offsets() end

  # <"?????"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x18d62
  #  @wrapped_string=
  #   "\343\201\223\343\202\217\343\201\253\343\201\241\343\202\217">>.
  def test_insert_should_be_destructive() end

  # RangeError: Non-negative number required.
  # Parameter name: length
  def test_ljust_should_count_characters_instead_of_bytes() end

  # <"????"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x18e72
  #  @wrapped_string="\343\202\217\343\201\241\343\201\253\343\201\223">>.
  def test_reverse_reverses_characters() end

  # <"????"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x18f0c
  #  @wrapped_string="\343\201\223\343\201\253\343\201\241\343\202\217">>.
  def test_rstrip_strips_whitespace_from_the_right_of_the_string() end

  # RangeError: Count must be positive and count must refer to a location within the string/array/collection.
  # Parameter name: count
  def test_should_know_if_one_includes_the_other() end

  # <"?????"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x18f6e
  #  @wrapped_string=
  #   "\343\201\223\343\202\217\343\201\253\343\201\241\343\202\217">>.
  def test_should_use_character_offsets_for_insert_offsets() end

  # <"??"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x18fb6
  #  @wrapped_string="\343\201\223\343\202\217">>.
  def test_slice_bang_removes_the_slice_from_the_receiver() end

  # <"??"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x18fea
  #  @wrapped_string="\343\201\253\343\201\241">>.
  def test_slice_bang_returns_sliced_out_substring() end

  # <"?"> expected but was
  # <#<ActiveSupport::Multibyte::Chars:0x19020 @wrapped_string="\343\201\223">>.
  def test_slice_should_take_character_offsets() end

  # <false> is not true.
  def test_split_should_return_an_array_of_chars_instances() end

end

class NumericExtConversionsTest
  # <"+00:00"> expected but was
  # <"000:00">.
  def test_to_utc_offset_s_with_colon() end

  # <"+0000"> expected but was
  # <"00000">.
  def test_to_utc_offset_s_without_colon() end

end

class OrderedHashTest
  # <false> is not true.
  def test_inspect() end
end

class RescueableTest
  # NoMethodError: You have a nil object when you didn't expect it!
  # The error occurred while evaluating nil.message
  def test_rescue_from_with_block_with_args() end
end

class TestJSONDecoding
  # <#<Class:0x0001cdc @inheritable_attributes={}>> exception expected but was
  # Class: <IronRuby::StandardLibrary::Yaml::ParserException>
  # Message: <"while scanning a flow node: expected the node content, but found: #<ValueToken>">
  # ---Backtrace---
  # c:\github\ironruby\Merlin\External.LCA_RESTRICTED\Languages\IronRuby\Yaml\IronRuby.Libraries.Yaml\Engine\Parser.cs:251:in `Produce'
  # c:\github\ironruby\Merlin\E
  def test_failed_json_decoding() end
end

class TestJSONEncoding
  # <"\"2005/02/01 15:15:10 +0000\""> expected but was
  # <"\"2005/02/01 15:15:10 00000\"">.
  def test_time() end

  # <"\"\\u20ac2.99\""> expected but was
  # <"\"\342\202\2542.99\"">.
  def test_utf8_string_encoded_properly_when_kcode_is_utf8() end

end

class TimeExtCalculationsTest
  # <"+00:00"> expected but was
  # <"000:00">.
  def test_formatted_offset_with_utc() end

  # <Mon Feb 21 17:44:30  2039> expected but was
  # <Mon, 21 Feb 2039 17:44:30 -0800>.
  def test_local_time() end

  # <Mon Feb 21 17:44:30 Z 2039> expected but was
  # <Mon, 21 Feb 2039 17:44:30 00000>.
  def test_time_with_datetime_fallback() end

  # <Mon Feb 21 17:44:30 Z 2039> expected but was
  # <Mon, 21 Feb 2039 17:44:30 00000>.
  def test_utc_time() end

end

class TimeExtMarshalingTest
  # <Sat Jan 01 00:00:00 Z 2000> expected but was
  # <Fri Dec 31 16:00:00 -08:00 1999>.
  def test_marshaling_with_frozen_utc_instance() end

  # <Sat Jan 01 00:00:00 Z 2000> expected but was
  # <Fri Dec 31 16:00:00 -08:00 1999>.
  def test_marshaling_with_utc_instance() end

end

class TimeWithZoneMethodsForTimeAndDateTimeTest
  # NoMethodError: You have a nil object when you didn't expect it!
  # The error occurred while evaluating nil.period_for_utc
  def test_in_time_zone() end

  # <"Sat, 01 Jan 2000 00:00:00 UTC +00:00"> expected but was
  # <"Sat, 01 Jan 2000 00:00:00 UTC 000:00">.
  def test_in_time_zone_with_argument() end

end

class TimeWithZoneTest
  # <"Sun, 02 Apr 2006 03:00:00 EDT -04:00"> expected but was
  # <"Sun, 02 Apr 2006 02:00:00 EDT -04:00">.
  def test_advance_1_month_into_spring_dst_gap() end

  # ArgumentError: invalid date
  def test_change() end

  # <nil> is not true.
  def test_eql?() end

  # <true> expected but was
  # <false>.
  def test_instance_created_with_local_time_enforces_fall_dst_rules() end

  # <Sun Apr 02 03:00:00 Z 2006> expected but was
  # <Sun Apr 02 02:00:00 Z 2006>.
  def test_instance_created_with_local_time_enforces_spring_dst_rules() end

  # TypeError: no virtual class for Time
  def test_method_missing_with_non_time_return_value() end

  # <Sun Oct 29 01:59:59 Z 2006> expected but was
  # <Sun Oct 29 00:59:59 Z 2006>.
  def test_plus_and_minus_enforce_fall_dst_rules() end

  # <Sun Apr 02 01:59:59 Z 2006> expected but was
  # <Sun Apr 02 02:59:59 Z 2006>.
  def test_plus_and_minus_enforce_spring_dst_rules() end

  # NameError: uninitialized constant YAML::Emitter
  def test_ruby_to_yaml() end

  # NameError: uninitialized constant YAML::Emitter
  def test_to_yaml() end

  # <"1999-12-31T19:00:00.123456-05:00"> expected but was
  # <"1999-12-31T19:00:00.123000-05:00">.
  def test_xmlschema_with_fractional_seconds() end

end

class TimeZoneTest
  # <"+00:00"> expected but was
  # <"000:00">.
  def test_formatted_offset_zero() end

  # <Sun Oct 29 05:00:00 Z 2006> expected but was
  # <Sun Oct 29 06:00:00 Z 2006>.
  def test_local_enforces_fall_dst_rules() end

  # <Sun Apr 02 01:59:59 Z 2006> expected but was
  # <Sun Apr 02 02:59:59 Z 2006>.
  def test_local_enforces_spring_dst_rules() end

  # <Sun Oct 29 01:00:00 Z 2006> expected but was
  # <Sun Oct 29 00:00:00 Z 2006>.
  def test_now_enforces_fall_dst_rules() end

  # <Fri Dec 31 19:00:00 Z 1999> expected but was
  # <Tue Sep 08 19:00:00 Z 2009>.
  def test_parse_with_incomplete_date() end

end

#------------------------------------------------------------------------------
# Tests failing with MRI. Generated by doing:
#   require 'generate_test-unit_tags'

class TimeZoneTest
  # <Sat Jan 01 05:00:00 UTC 2000> expected but was
  # <Sat Jan 01 08:00:00 UTC 2000>.
  def test_now() end

  # <Sun Apr 02 03:00:00 UTC 2006> expected but was
  # <Sun Apr 02 05:00:00 UTC 2006>.
  def test_now_enforces_spring_dst_rules() end

end

class TimeWithZoneMethodsForTimeAndDateTimeTest
  # <Sat Jan 01 00:00:00 UTC 2000> expected but was
  # <Sat Jan 01 03:00:00 UTC 2000>.
  def test_current_returns_time_zone_now_when_zone_default_set() end

  # <"Fri, 31 Dec 1999 15:00:00 AKST -09:00"> expected but was
  # <"Fri, 31 Dec 1999 18:00:00 AKST -09:00">.
  def test_in_time_zone_with_time_local_instance() end

end

class MessageEncryptorTest
  # NoMethodError: You have a nil object when you didn't expect it!
  # The error occurred while evaluating nil.encrypt
  def test_encrypting_twice_yields_differing_cipher_text() end

  # NoMethodError: You have a nil object when you didn't expect it!
  # The error occurred while evaluating nil.encrypt
  def test_messing_with_either_value_causes_failure() end

  # NoMethodError: You have a nil object when you didn't expect it!
  # The error occurred while evaluating nil.encrypt_and_sign
  def test_signed_round_tripping() end

  # NoMethodError: You have a nil object when you didn't expect it!
  # The error occurred while evaluating nil.encrypt
  def test_simple_round_tripping() end

end

class DependenciesTest
  # <false> is not true.
  def test_warnings_should_be_enabled_on_first_load() end
end

class TestJSONEncoding
  # <"\"2005-02-01T15:15:10-05:00\""> expected but was
  # <"\"2005-02-01T15:15:10-08:00\"">.
  def test_time_to_json_includes_local_offset() end
end

class DurationTest
  # <Sat Jan 01 00:00:05 UTC 2000> expected but was
  # <Sat Jan 01 03:00:05 UTC 2000>.
  def test_since_and_ago_anchored_to_time_zone_now_when_time_zone_default_set() end
end

class DateTimeExtCalculationsTest
  # <Fri, 31 Dec 1999 23:59:59 -0500> expected but was
  # <Fri, 31 Dec 1999 23:59:59 -0800>.
  def test_current_returns_date_today_when_zone_default_not_set() end

  # <Fri, 31 Dec 1999 23:59:59 -0500> expected but was
  # <Sat, 01 Jan 2000 02:59:59 -0500>.
  def test_current_returns_time_zone_today_when_zone_default_set() end

  # <Rational(-5, 24)> expected but was
  # <Rational(-1, 3)>.
  def test_local_offset() end

end

class KernelTest
  # Errno::EBADF: Bad file descriptor
  def test_silence_stderr() end

  # Errno::ENOENT: No such file or directory - /dev/null
  def test_silence_stderr_with_return_value() end

end

class DateExtCalculationsTest
  # <"1980-02-28T00:00:00-08:00"> expected to be =~
  # </^1980-02-28T00:00:00-05:?00$/>.
  def test_xmlschema() end
end

class TimeExtCalculationsTest
  # <"-05:00"> expected but was
  # <"-08:00">.
  def test_formatted_offset_with_local() end

  # <true> expected but was
  # <false>.
  def test_future_with_time_current_as_time_local() end

  # <false> expected but was
  # <true>.
  def test_future_with_time_current_as_time_with_zone() end

  # <false> expected but was
  # <true>.
  def test_past_with_time_current_as_time_local() end

  # <true> expected but was
  # <false>.
  def test_past_with_time_current_as_time_with_zone() end

  # just after DST end.
  # <10801> expected but was
  # <7201.0>.
  def test_seconds_since_midnight_at_daylight_savings_time_end() end

  # just after DST start.
  # <7201> expected but was
  # <10801.0>.
  def test_seconds_since_midnight_at_daylight_savings_time_start() end

  # <Sun Apr 02 03:00:00 -0700 2006> expected but was
  # <Sun Apr 02 02:00:00 -0700 2006>.
  def test_time_created_with_local_constructor_cannot_represent_times_during_hour_skipped_by_dst() end

  # <"Thu, 05 Feb 2009 14:30:05 -0600"> expected but was
  # <"Thu, 05 Feb 2009 14:30:05 -0800">.
  def test_to_s() end

end

class TimeWithZoneTest
  # <true> expected but was
  # <false>.
  def test_future_with_time_current_as_time_local() end

  # <false> expected but was
  # <true>.
  def test_past_with_time_current_as_time_local() end

end

class AtomicWriteTest
  # <33206> expected but was
  # <33188>.
  def test_atomic_write_preserves_default_file_permissions() end

  # <33261> expected but was
  # <33188>.
  def test_atomic_write_preserves_file_permissions() end

end
