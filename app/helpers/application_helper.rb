require 'uri'

module ApplicationHelper
  # Produces more user-friendly shortcut for link
  def custom_reference_problem(ref_name)
    link_name = ref_name.split("\n")
    links = []
    link_name.each do |pair|
      links << produce_link(pair)
    end
    links
  end

  private

  # tools for custom_reference_problem
  def extract_domain_name(raw_link)
    return '' if raw_link.blank?
    uri = URI.parse(raw_link)
    uri = URI.parse("http://#{raw_link}") if uri.scheme.nil?
    host = uri.host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end

  def produce_link(link_name)
    s = link_name.split(' ')
    token = if s.count == 1
              extract_domain_name(s[0])
            else
              s[1]
            end

    uri = URI.parse(s[0])
    return link_to token, "https://#{s[0]}" if uri.scheme.nil?
    link_to token, "#{s[0]}"

  end
end
