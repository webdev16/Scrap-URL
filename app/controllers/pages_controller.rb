class PagesController < ApplicationController
  def index
    pages = Page.all
    render_json pages: pages
  end

  def create
    uri = URI.parse(params[:url])
    tags = Nokogiri.parse(Net::HTTP.get uri)
    contents = []
    
    tags.css('h1', 'h2', 'h3').each do |tag|
      contents << tag.text
    end

    tags.css('a').each do |tag|
      contents << tag.attributes['href'].value
    end

    page = Page.find_or_create_by(url: params[:url])
    page.assign_attributes(content: contents.join(', '))

    if page.valid?
      page.save
      render_json page: page
    else
      render_err page.errors.full_messages, 400
    end
  rescue
    render_err "Invalid url: #{params[:url]}", 400
  end

  def show
    page = Page.find_by(id: params[:id])

    if page.present?
      render_json page: page
    else
      render_err 'No page', 404
    end
  end
end
