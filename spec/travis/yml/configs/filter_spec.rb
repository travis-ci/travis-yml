require 'spec_helper'

describe Travis::Yml::Configs::Filter, 'notifications' do
  let(:data) { { branch: 'master' } }
  let(:msg) { { type: 'config', level: :info, key: :'notifications.email', code: :condition, args: { target: :email, condition: 'false' } } }
  let(:env) { {} }

  subject { described_class.new({ env: env, notifications: config }, [], data) }

  matcher :have_config do |expected|
    match do |filter|
      filter.apply
      actual = filter.config[:notifications]
      expected ? actual == expected : !actual.nil?
    end
  end

  matcher :have_msg do |expected|
    match do |filter|
      filter.apply
      actual = filter.msgs
      expected ? actual.include?(expected) : !actual.empty?
    end
  end

  describe 'given an array of hashes with no condition' do
    let(:config) { [email: { recipients: 'me@email.com' }] }
    it { should have_config config }
    it { should_not have_msg }
  end

  describe 'given an array of hashes with a matching condition' do
    let(:config) { [email: { recipients: 'me@email.com', if: 'true' }] }
    it { should have_config config }
    it { should_not have_msg }
  end

  describe 'given an array of hashes with a failing condition' do
    let(:config) { [email: { recipients: 'me@email.com', if: 'false' }] }
    it { should_not have_config }
    it { should have_msg msg }
  end

  describe 'given a hash with no condition' do
    let(:config) { { email: { recipients: 'me@email.com' } } }
    it { should have_config config }
    it { should_not have_msg }
  end

  describe 'given a hash with a matching condition' do
    let(:config) { { email: { recipients: 'me@email.com', if: 'true' } } }
    it { should have_config config }
    it { should_not have_msg }
  end

  describe 'given a hash with a failing condition' do
    let(:config) { { email: { recipients: 'me@email.com', if: 'false' } } }
    it { should_not have_config }
    it { should have_msg msg }
  end

  describe 'given a hash with a false value' do
    let(:config) { { email: { recipients: 'me@email.com', on_pull_requests: true } } }
    it { should have_config config }
    it { should_not have_msg }
  end

  describe 'given a hash with a false value' do
    let(:config) { { email: { recipients: 'me@email.com', on_pull_requests: false } } }
    it { should have_config config }
    it { should_not have_msg }
  end

  describe 'given a hash with a nil value' do
    let(:config) { { email: { recipients: 'me@email.com', on_pull_requests: nil } } }
    it { should have_config email: { recipients: 'me@email.com' } }
    it { should_not have_msg }
  end

  describe 'given email: string' do
    let(:config) { { email: 'me@email.com' } }
    it { should have_config config }
    it { should_not have_msg }
  end

  describe 'given email: true' do
    let(:config) { { email: true } }
    it { should have_config config }
    it { should_not have_msg }
  end

  describe 'given email: nil' do
    let(:config) { { email: nil } }
    it { should_not have_config }
    it { should_not have_msg }
  end

  describe 'given a string' do
    let(:config) { 'str' }
    it { should have_config config }
    it { should_not have_msg }
  end

  describe 'given true' do
    let(:config) { true }
    it { should have_config config }
    it { should_not have_msg }
  end

  describe 'given nil' do
    let(:config) { nil }
    it { should_not have_config }
    it { should_not have_msg }
  end

  describe 'given a condition using env' do
    describe 'env var present' do
      let(:config) { { email: { recipients: 'me@email.com', if: 'env(FOO)' } } }
      let(:env) { { FOO: 'foo' } }
      it { should have_config email: { recipients: 'me@email.com', if: 'env(FOO)' } }
      it { should_not have_msg }
    end

    describe 'env var missing' do
      let(:config) { { email: { recipients: 'me@email.com', if: 'env(FOO)' } } }
      it { should_not have_config }
      it { should have_msg type: 'config', level: :info, key: :'notifications.email', code: :condition, args: { target: :email, condition: 'env(FOO)' } }
    end
  end

  describe 'given a condition using branch' do
    describe 'branch matches' do
      let(:config) { { email: { recipients: 'me@email.com', if: 'branch = master' } } }
      it { should have_config email: { recipients: 'me@email.com', if: 'branch = master' } }
      it { should_not have_msg }
    end

    describe 'branch does not match' do
      let(:config) { { email: { recipients: 'me@email.com', if: 'branch = other' } } }
      it { should_not have_config }
      it { should have_msg type: 'config', level: :info, key: :'notifications.email', code: :condition, args: { target: :email, condition: 'branch = other' } }
    end
  end
end
