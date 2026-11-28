*** Settings ***
Documentation     Localisateurs centralises (theme "classic" de PrestaShop 8).
...               En cas de changement de version ou de theme, SEUL ce fichier est a ajuster.

*** Variables ***
# ---------- Front-office : connexion ----------
${LOC_LOGIN_FORM}              id=login-form
${LOC_LOGIN_EMAIL}             css:#login-form input[name='email']
${LOC_LOGIN_PASSWORD}          css:#login-form input[name='password']
${LOC_LOGIN_SUBMIT}            id=submit-login
${LOC_LOGIN_ERROR}             css:.alert-danger
${LOC_LOGOUT_LINK}             css:a.logout

# ---------- Front-office : inscription ----------
${LOC_REG_FORM}                id=customer-form
${LOC_REG_FIRSTNAME}           css:#customer-form input[name='firstname']
${LOC_REG_LASTNAME}            css:#customer-form input[name='lastname']
${LOC_REG_EMAIL}               css:#customer-form input[name='email']
${LOC_REG_PASSWORD}            css:#customer-form input[name='password']
${LOC_REG_SUBMIT}              css:#customer-form button[data-link-action='save-customer']

# ---------- Front-office : recherche et catalogue ----------
${LOC_SEARCH_INPUT}            css:#search_widget input[name='s']
${LOC_PRODUCT_MINIATURE}       css:article.product-miniature
${LOC_PRODUCT_THUMB}           css:article.product-miniature a.product-thumbnail

# ---------- Front-office : produit et panier ----------
${LOC_ADD_TO_CART}             css:button.add-to-cart
${LOC_CART_MODAL}              id=blockcart-modal
${LOC_QTY_INPUT}               id=quantity_wanted
${LOC_CART_REMOVE}             css:a.remove-from-cart
${LOC_CART_EMPTY}              css:.no-items
${LOC_CART_CHECKOUT_BTN}       css:.cart-detailed-actions a.btn-primary

# ---------- Front-office : tunnel de commande ----------
${LOC_ADDR_ADDRESS1}           css:input[name='address1']
${LOC_ADDR_POSTCODE}           css:input[name='postcode']
${LOC_ADDR_CITY}               css:input[name='city']
${LOC_CONFIRM_ADDRESSES}       css:button[name='confirm-addresses']
${LOC_CONFIRM_DELIVERY}        css:button[name='confirmDeliveryOption']
${LOC_PAYMENT_OPTION}          id=payment-option-1
${LOC_TERMS_CHECKBOX}          css:input[name='conditions_to_approve[terms-and-conditions]']
${LOC_PLACE_ORDER}             css:#payment-confirmation button[type='submit']
${LOC_ORDER_CONFIRMATION}      id=content-hook_order_confirmation

# ---------- Front-office : formulaire de contact ----------
${LOC_CONTACT_EMAIL}           css:input[name='from']
${LOC_CONTACT_MESSAGE}         css:textarea[name='message']
${LOC_CONTACT_SUBMIT}          css:input[name='submitMessage']

# ---------- Back-office ----------
${LOC_BO_EMAIL}                id=email
${LOC_BO_PASSWORD}             id=passwd
${LOC_BO_SUBMIT}               id=submit_login
${LOC_BO_LOGOUT}               id=header_logout
${LOC_BO_ERROR}                css:#error, .alert-danger
${LOC_BO_NEW_PRODUCT}          id=page-header-desc-configuration-add
${LOC_BO_PRODUCT_NAME}         id=product_header_name_1
${LOC_BO_PRODUCT_PRICE}        id=product_pricing_retail_price_price_tax_excluded
${LOC_BO_PRODUCT_SAVE}         id=product_footer_save
