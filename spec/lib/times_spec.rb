require 'rspec'
require 'whenever'
require 'ice_cube'

class TimeConversions

  DEFAULT_RULE_COUNT = 2

  def self.convert(recurrence)
    if recurrence.is_a? IceCube::Rule
      schedule = IceCube::Schedule.new
      schedule.add_recurrence_rule recurrence.count(DEFAULT_RULE_COUNT)
      occurrence = schedule.all_occurrences
      time_in_seconds = occurrence.last.to_time.to_i - occurrence.first.to_time.to_i
      time_in_seconds
    else
      recurrence
    end
  end

end

describe 'IceCube To Whenever cron syntax' do

  let(:cron_result) { "0 0 1,8,15,22 * *" }
  let(:at_time) { nil }
  let(:time_in_cron) { Whenever::Output::Cron.new(time, nil, at_time).time_in_cron_syntax }

  describe ActiveSupport::Duration do
    let(:time) { 1.week }

    it 'converts regular time to cron syntax' do
      expect(time_in_cron).to eq cron_result
    end
  end

  describe :time_in_seconds do
    let(:time) { 1.week.to_i }

    it 'converts time in seconds to cron syntax' do
      expect(time_in_cron).to eq cron_result
    end
  end

  describe :ice_cube do

    let(:time) { TimeConversions.convert(time_rule) }

    describe :daily do
      let(:cron_result) { "0 0 * * *" }
      let(:time_rule) { IceCube::Rule.daily }

      it 'converts ice_cube time to cron syntax' do
        expect(time_in_cron).to eq cron_result
      end
    end

    describe :weekly do
      let(:cron_result) { "0 0 1,8,15,22 * *" }
      let(:time_rule) { IceCube::Rule.weekly }

      it 'converts ice_cube time to cron syntax' do
        expect(time_in_cron).to eq cron_result
      end
    end

    describe :monthly do
      let(:cron_result) { "0 0 1 * *" }
      let(:time_rule) { IceCube::Rule.monthly }

      it 'converts ice_cube time to cron syntax' do
        expect(time_in_cron).to eq cron_result
      end
    end

    describe :date_with_interval do
      let(:cron_result) { "0 0 1,5,9,13,17,21,25,29 * *" }
      let(:time_rule) { IceCube::Rule.daily(4) }

      it 'converts ice_cube time to cron syntax' do
        expect(time_in_cron).to eq cron_result
      end
    end

    describe :date_with_time do

      let(:at_time) { '12:20am' }
      let(:cron_result) { "20 0 1 * *" }
      let(:time_rule) { IceCube::Rule.monthly }

      it 'converts ice_cube time to cron syntax' do
        expect(time_in_cron).to eq cron_result
      end
    end

  end

end
