# frozen_string_literal: true

require 'rspec-parameterized'

describe IntClosedSection do
  describe '#initialize' do
    context '下端点より上端点が大きいとき' do
      let(:int_closed_section) { IntClosedSection.new(lower_limit: 3, upper_limit: 8) }

      it { expect(int_closed_section).to have_attributes(lower_limit: 3, upper_limit: 8) }
    end

    context '下端点と上端点が等しいとき' do
      let(:int_closed_section) { IntClosedSection.new(lower_limit: 3, upper_limit: 3) }

      it { expect(int_closed_section).to have_attributes(lower_limit: 3, upper_limit: 3) }
    end

    context '上端点より下端点が大きいとき' do
      subject { -> { IntClosedSection.new(lower_limit: 8, upper_limit: 3) }}

      it { is_expected.to raise_error(WrongRangeInputError) }
    end

    context '整数以外の入力のとき' do
      subject { -> { IntClosedSection.new(lower_limit: "23", upper_limit: "34") }}

      it { is_expected.to raise_error(WrongTypeInputError) }
    end
  end

  describe '#to_s' do
    context '[3, 8]の整数閉区間オブジェクトのとき' do
      subject { IntClosedSection.new(lower_limit: 3, upper_limit: 8).to_s }

      it { is_expected.to eq "[3,8]"}
    end
  end

  describe '#include_int?' do
    subject { IntClosedSection.new(lower_limit: 3, upper_limit: 8).include_int?(param) }
    context '[3,8]の整数閉区間オブジェクトのとき' do
      context '3を与えた時' do
        let(:param) { 3 }

        it { is_expected.to eq true }
      end

      context '8を与えた時' do
        let(:param) { 3 }

        it { is_expected.to eq true }
      end

      context '2を与えた時' do
        let(:param) { 2 }

        it { is_expected.to eq false }
      end

      context '9を与えた時' do
        let(:param) { 9 }

        it { is_expected.to eq false }
      end

      context '整数以外を与えた時' do
        let(:param) { '10' }

        it 'WrongTypeInputErrorを吐く' do
          expect { subject }.to raise_error(WrongTypeInputError)
        end
      end
    end
  end

  describe '#include_section?' do
    subject { IntClosedSection.new(lower_limit: 3, upper_limit: 8).include_section?(param) }

    context '[3,8]の整数閉区間オブジェクトのとき' do
      context '整数閉区間を与えた時' do
        where(:description, :lower_limit, :upper_limit, :expected_value) do
          [
              ['[3,8]を与えた時', 3, 8, true],
              ['[2,8]を与えた時', 2, 8, false],
              ['[3,9]を与えた時', 3, 9, false],
              ['[2,9]を与えた時', 2, 9, false],
          ]
        end

        with_them do
          let(:param) { IntClosedSection.new(lower_limit: lower_limit, upper_limit: upper_limit) }

          it {is_expected.to eq expected_value}
        end
      end

      context '整数閉区間以外を与えたとき' do
        let(:param) { 1 }

        it 'WrongTypeInputErrorを吐く' do
          expect { subject }.to raise_error(WrongTypeInputError)
        end
      end
    end
  end

  describe "等価判定" do
    shared_examples_for '等価判定' do
      context '[3,8]と[3,8]' do
        let(:params) { {lower_limit: 3, upper_limit: 8} }

        it { is_expected.to eq true }
      end

      context '[3,8]と[2,8]' do
        let(:params) { {lower_limit: 2, upper_limit: 8} }

        it { is_expected.to eq false }
      end
    end

    describe '#===' do
      subject { IntClosedSection.new(lower_limit: 3, upper_limit: 8) === IntClosedSection.new(**params) }
      it_behaves_like '等価判定'
    end

    describe '#equal_to?' do
      subject { IntClosedSection.new(lower_limit: 3, upper_limit: 8).equal_to?(IntClosedSection.new(**params)) }

      it_behaves_like '等価判定'
    end
  end
end