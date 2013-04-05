# encoding: utf-8
if $os == :ios
=begin
name, names, text, text should match substring and case insensitive.

iOS .name() is the accessibility attribute. If not defined, then .label() is used instead.
This differs from Android where name (the content description) is empty when not set.

name defaults to label when undefined. value is never a default so that must be
included in a new search.

Find - search everything.

The search order is:
1. name
2. label (implied by name)
3. value

=end

# Return the first element matching text.
# @param text [String] the text to search for
# @return [Element] the first matching element
def find text
  # returnElems requires a wrapped $(element).
  # set to empty array when length is zero to prevent hang.
  js = %Q(
    var eles = au.mainWindow.elements();
    var a = eles.firstWithPredicate("name contains[c] '#{text}' || label contains[c] '#{text}' || value contains[c] '#{text}'");
    if ( a.length === 0 ) {
      a = [];
    }
    au._returnElems($(a));
  )

  execute_script(js).first
end

# Return all elements matching text.
# @param text [String] the text to search for
# @return [Array<Element>] all matching elements
def finds text
  # returnElems requires a wrapped $(element).
  # must call toArray when using withPredicate instead of firstWithPredicate.
  js = %Q(
    var eles = au.mainWindow.elements();
    var a = eles.withPredicate("name contains[c] '#{text}' || label contains[c] '#{text}' || value contains[c] '#{text}'").toArray();
    if ( a.length === 0 ) {
      a = [];
    }
    au._returnElems($(a));
  )

  execute_script js
end

end # if ios