module ApplicationHelper


  def custom_reference_problem(ref_name)
    # dodac nowe linie
    splitted = ref_name.split(' ')

    if splitted.count == 1
      token = make_default_name(splitted[0])
      get_rid_of_http(splitted[0])
      return link_to token, "http://#{splitted[0]}"
    else

      return link_to splitted[1], "http://#{splitted[0]}"
    end
  end

  private

  def make_default_name(string_tokenize)
    return '' if string_tokenize.blank?
    return string_tokenize.split('@').last if string_tokenize.match('@')
    link = string_tokenize
    link = "http://#{link}" unless link.match(/^(http:\/\/|https:\/\/)/)
    link = URI.parse(URI.encode(link)).host.present? ? URI.parse(URI.encode(link)).host : link.strip
    domain_name = link.sub(/.*?www./,'')
    domain_name = domain_name.match(/[A-Z]+.[A-Z]{2,4}$/i).to_s if domain_name.split('.').length >= 2 && domain_name.match(/[A-Z]+.[A-Z]{2,4}$/i).present?
  end

  def get_rid_of_http(string_clean)
    string_clean.remove!('http://')
    string_clean.remove!('https://')
  end

end
