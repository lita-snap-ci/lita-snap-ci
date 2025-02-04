require "spec_helper"

describe Lita::Handlers::SnapCi, lita_handler: true do
  context 'with valid projects' do
    before do
      load_config
    end

    describe 'command `snap-ci report`:' do
      it 'display a general report' do
        send_message("snap-ci report")

        load_message_fixture('snap-ci_report').each_line do |line|
          expect(replies.last).to include(line.delete("\n"))
        end
      end
    end

    describe 'command `snap-ci project`:' do
      context 'with only repo format' do
        it 'displays the project status' do
          send_message("snap-ci project api")

          load_message_fixture('snap-ci_status').each_line do |line|
            expect(replies.last).to include(line.delete("\n"))
          end
        end
      end

      context 'with owner/repo format' do
        it 'displays the project status' do
          send_message("snap-ci project oneorg/api")

          load_message_fixture('snap-ci_status').each_line do |line|
            expect(replies.last).to include(line.delete("\n"))
          end
        end
      end
    end
  end
  context 'with invalid projects' do
    before do
      load_wrong_config
    end

    describe 'command `snap-ci report`:' do
      it 'display a general report with the failure message' do
        send_message("snap-ci report")

        load_message_fixture('error').each_line do |line|
          expect(replies.last).to include(line.delete("\n"))
        end
      end
    end

    describe 'command `snap-ci project`:' do
      context 'with only repo format' do
        it 'displays the project status with the failure message' do
          send_message("snap-ci project wrong_project")

          load_message_fixture('error').each_line do |line|
            expect(replies.last).to include(line.delete("\n"))
          end
        end
      end

      context 'with owner/repo format' do
        it 'displays the project status with the failure message' do
          send_message("snap-ci project wrong_org/wrong_project")

          load_message_fixture('error').each_line do |line|
            expect(replies.last).to include(line.delete("\n"))
          end
        end
      end
    end
  end
end
