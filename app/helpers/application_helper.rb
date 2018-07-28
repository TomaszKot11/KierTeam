module ApplicationHelper

  # produces more user-friendly
  # links with given by user name
  # or from domain name
  def custom_reference_problem(ref_name)
    link_name = ref_name.split("\n")
    links = []
    link_name.each do |pair|
      links << produce_link(pair)
    end
    return links
  end

  private

  # tools for custom_reference_problem
  def extract_domain_name(raw_link)
    return '' if raw_link.blank?
    link = raw_link
    link = "http://#{raw_link}" unless raw_link.match(/^(http:\/\/|https:\/\/)/)
    link = URI.parse(URI.encode(link)).host.present? ? URI.parse(URI.encode(link)).host : link.strip
    domain_name = link.sub(/.*?www./,'')
    domain_name = domain_name.match(/[A-Z]+.[A-Z]{2,4}$/i).to_s if domain_name.split('.').length >= 2 && domain_name.match(/[A-Z]+.[A-Z]{2,4}$/i).present?
  end

  def get_rid_of_http(string_clean)
    string_clean.remove!('http://')
    string_clean.remove!('https://')
  end

  def produce_link(link_name)
    split = link_name.split(' ')
    token = 'REFERENCE'
    if split.count == 1
      # user didn't provide name
      token = extract_domain_name(split[0])
      get_rid_of_http(split[0])
    else
      # user provided name
      get_rid_of_http(split[0])
      token = split[1]
    end
    return link_to token, "http://#{split[0]}"
  end

end
