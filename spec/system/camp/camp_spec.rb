require 'rails_helper'

RSpec.describe 'キャンプ', type: :system do
  let(:user) { create(:user) }
  let(:camp) { create(:camp, user_id: user.id) }

  describe 'campのCRUD' do
    describe 'campの一覧' do
      context 'ログインしていない場合' do
        it 'topページにリダイレクトされること' do
          visit camps_path
          expect(current_path).to eq(root_path), 'topページにリダイレクトされていません'
        end
      end

      context 'ログインしている場合' do
        it 'サイドメニューからキャンプ一覧へ遷移できること' do
          login
          click_on('マイキャンプ')
          expect(current_path).to eq(camps_path), 'マイキャンプ画面へ遷移できません'
        end

        context 'campが一件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            login
            click_on('マイキャンプ')
            expect(page).to have_content('キャンプのキロクはまだありません'), 'キャンプが一件もない場合、「キャンプのキロクはまだありません」というメッセージが表示されていません'
          end
        end
      end
    end

    describe 'campの詳細' do
      context 'ログインしていない場合' do
        it 'topページにリダイレクトされること' do
          visit camps_path
          expect(current_path).to eq(root_path), 'topページにリダイレクトされていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login_and_create_camp
        end
        it 'campの詳細が表示されること' do
          visit camps_path
          visit '/camps/1'
          expect(page).to have_content('test_title'), 'camp詳細画面にタイトルが表示されていません'
          expect(page).to have_content('test_note'), 'camp詳細画面にコメントが表示されていません'
        end
      end
    end

    describe 'campの作成' do
      context 'ログインしていない場合' do
        it 'topページにリダイレクトされること' do
          visit '/camps/new'
          expect(current_path).to eq(root_path), 'ログインしていない場合、キャンプ作成画面にアクセスした際に、ログインページにリダイレクトされていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login
        end

        it 'campが作成できること' do
          visit new_camp_path
          fill_in 'camp_title', with: 'テストタイトル'
          fill_in 'camp_note', with: 'テスト本文'
          click_button '登録'
          expect(current_path).to eq(camps_path), 'camp一覧画面に遷移していません'
          expect(page).to have_content('テストタイトル'), 'タイトルが表示されていません'
          expect(page).to have_content('テスト本文'), 'コメントが表示されていません'
        end

        it 'campの作成に失敗すること' do
          visit new_camp_path
          click_button '登録'
          expect(page).to have_content('Titleを入力してください'), 'フラッシュメッセージ「Titleを入力してください」が表示されていません'
        end
      end
    end

    describe 'campの更新' do
      before { camp }
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit edit_camp_path(camp)
          expect(current_path).to eq(root_path), 'topページにリダイレクトされていません'
        end
      end

      context 'ログインしている場合' do
        context '自分のcamp' do
          before do
            login_and_create_camp
            visit camps_path
            find('.card-body').click
            page.all('#dropdownMenuButton')[1].click
            click_on '写真を追加・編集'
          end
          it 'campが更新できること' do
            fill_in 'camp_title', with: '編集後テストタイトル'
            fill_in 'camp_note', with: '編集後テスト本文'
            click_button '登録'
            # expect(current_path).to eq camps_path(camp)
            expect(page).to have_content('編集後テストタイトル'), '更新後のタイトルが表示されていません'
            expect(page).to have_content('編集後テスト本文'), '更新後の本文が表示されていません'
          end

          it 'campの作成に失敗すること' do
            fill_in 'camp_title', with: ''
            fill_in 'camp_note', with: '編集後テスト本文'
            click_button '登録'
            expect(page).to have_content('Titleを入力してください'), 'フラッシュメッセージ「Titleを入力してください」が表示されていません'
          end
        end
      end
    end

    describe 'campの削除' do
      before do
        login_and_create_camp
        visit camps_path
        find('.card-body').click
      end
      context '自分の掲示板' do
        it 'campが削除できること' do
          page.all('#dropdownMenuButton')[0].click
          click_on 'キャンプを削除'
          expect(page.accept_confirm).to eq 'このキャンプを削除しますか？'
          expect(current_path).to eq(camps_path), 'camp削除後に、camp一覧ページに遷移していません'
        end
      end
    end
  end
end
