class Admins::BaseController < ApplicationController
  before_action :require_admin_logged_in
end