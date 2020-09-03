module EmailHelper
  
  STYLES = {
    button: 'background-color:#60aed8',
    footer: 'background-color: #000000; text-align: center; width: 100%; height: auto;',
    div: 'background-color: #ffffff; text-align: center; padding:10px; width: 100%; height: auto;',
    h1: 'margin-bottom: 20px; margin-top: 10px; font-size: 32px; color:#000000;',
    h2: 'margin-bottom: 10px; margin-top: 15px; font-size: 18px;color:#000000;',
    h3: 'margin-bottom: 10px; margin-top: 15px; font-size: 14px;color:#000000; text-align:left;',
    a: 'text-decoration: none; color: #ffffff;',
    p: 'margin-bottom: 10px; line-height: 20px; color:#000000;',
    label: 'color: #d3d3d3 ; font-weight: lighter; height:5px;'
 }

  def email_tag(type, options = {}, &content)
    options[:style] ||= STYLES[type]
    options[:target] = '_blank' if type == :a
    content_tag type, options, &content
  end
end
