require 'rails_helper'

RSpec.describe 'ログイン・ログアウト', type: :system do
  let(:user) { create(:user) }
  let!(:guest_user) {create(:guest_user)}

  describe '通常画面' do
    describe 'ログイン' do
      context '認証情報が正しい場合' do
        it 'ログインできること' do
          visit '/login'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          click_button 'ログイン'
          expect(current_path).to eq "/users/#{user.id}/every_camp"
          expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていません'
        end
      end

      context 'PWに誤りがある場合' do
        it 'ログインできないこと' do
          visit '/login'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: '1234'
          click_button 'ログイン'
          expect(current_path).to eq('/login'), 'ログイン失敗時にログイン画面に戻ってきていません'
          expect(page).to have_content('ログインに失敗しました'), 'フラッシュメッセージ「ログインに失敗しました」が表示されていません'
        end
      end
    end

    describe 'ログアウト' do
      before do
        login
      end
      it 'ログアウトできること' do
        click_on('ログアウト')
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq root_path
        expect(page).to have_content('ログアウトしました'), 'フラッシュメッセージ「ログアウトしました」が表示されていません'
      end
    end

    describe 'ゲストユーザーログイン' do
      it 'ログインできること' do
        visit root_path
        click_on 'ゲストユーザーでログイン', match: :first
        expect(current_path).to eq "/users/#{guest_user.id}/every_camp"
        expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていません'
      end
    end
  end
end
