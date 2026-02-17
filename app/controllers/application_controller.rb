class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #allow_browser versions: :modern

  # ↓↓↓ ここから追加・編集 ↓↓↓

  # Deviseの認証機能を一時的に無効化（コメントアウトする、または何もしないメソッドにする）
  # before_action :authenticate_customer! 

  # current_customer を呼ぶと、常に「最初の会員（テスト花子）」を返すようにする
  def current_customer
    @current_customer ||= Customer.first
  end
  
  # ビュー（画面）でも使えるようにする
  helper_method :current_customer

  # 認証チェックを「常にOK」にする
  def authenticate_customer!
    true
  end

  # ↑↑↑ ここまで追加・編集 ↑↑↑
end
