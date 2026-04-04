*** Settings ***
Documentation    Centralized variables for URLs, selectors and test data.


*** Variables ***
# URLs
${BASE_URL}              http://127.0.0.1:8000
${FLIGHTS_URL}           ${BASE_URL}/flights/
${SEARCH_URL}            ${BASE_URL}/flights/search/
${LOGIN_URL}             ${BASE_URL}/users/login
${LOGOUT_URL}            ${BASE_URL}/users/logout
${INVALID_FLIGHT_URL}    ${BASE_URL}/flights/999/

# Credentials
${ADMIN_USER}            anasse
${ADMIN_PASS}            anasse

# Timeouts
${SHORT_TIMEOUT}         5s
${DEFAULT_TIMEOUT}       10s
${LONG_TIMEOUT}          30s

# Selectors — Navigation
${SEL_FLIGHT_LINK}            css:[data-test='flight-details-link']
${SEL_PAGE_TITLE_FLIGHTS}     css:[id='page-title-flights']
${SEL_FLIGHT_HEADER}          css:[id='flight-header']
${SEL_BACK_TO_FLIGHTS}        css:[data-testid='back-to-flights']
${SEL_BTN_GO_TO_SEARCH}       css:[data-testid='btn-go-to-search']

# Selectors — Flight Detail
${SEL_DETAIL_ORIGIN}          css:[id='detail-origin']
${SEL_DETAIL_DESTINATION}     css:[id='detail-destination']
${SEL_DETAIL_DURATION}        css:[id='detail-duration']
${SEL_DETAIL_STATUS}          css:[data-testid='detail-status']
${SEL_DETAIL_CAPACITY}        css:[data-testid='detail-capacity']
${SEL_PASSENGER_COUNT}        css:[data-testid='passenger-count']

# Selectors — Passenger List
${SEL_PASSENGER_LIST}         css:[data-testid='passenger-list']
${SEL_PASSENGER_ITEM}         css:[data-testid='passenger-item']
${SEL_PASSENGER_NAME}         css:[data-testid='passenger-name']
${SEL_PASSENGER_SEAT}         css:[data-testid='passenger-seat']
${SEL_PASSENGER_CLASS}        css:[data-testid='passenger-class']
${SEL_PASSENGER_PASSPORT}     css:[data-testid='passenger-passport']
${SEL_PASSENGER_EMAIL}        css:[data-testid='passenger-email']
${SEL_NO_PASSENGERS}          css:[data-testid='no-passengers']
${SEL_BTN_REMOVE}             css:[data-testid='btn-remove']

# Selectors — Add Passenger Modal
${SEL_BTN_OPEN_MODAL}         css:[data-testid='btn-open-add-passenger']
${SEL_MODAL}                  css:[data-testid='modal-add-passenger']
${SEL_INPUT_FIRST}            css:[data-testid='input-first']
${SEL_INPUT_LAST}             css:[data-testid='input-last']
${SEL_INPUT_EMAIL}            css:[data-testid='input-email']
${SEL_INPUT_PASSPORT}         css:[data-testid='input-passport']
${SEL_INPUT_SEAT_CLASS}       css:[data-testid='input-seat-class']
${SEL_BTN_CONFIRM}            css:[data-testid='btn-confirm-add-passenger']
${SEL_BTN_CANCEL_MODAL}       css:[data-testid='btn-cancel-modal']
${SEL_BOOKING_ERROR}          css:[data-testid='booking-error']
${SEL_BOOKING_DISABLED}       css:[data-testid='booking-disabled']

# Selectors — Status
${SEL_STATUS_FORM}            css:[data-testid='status-form']
${SEL_STATUS_SELECT}          css:[data-testid='status-select']
${SEL_BTN_UPDATE_STATUS}      css:[data-testid='btn-update-status']
${SEL_NO_STATUS_TRANSITION}   css:[data-testid='no-status-transition']
${SEL_STATUS_ERROR}           css:[data-testid='status-error']

# Selectors — Search
${SEL_SEARCH_FORM}            css:[data-testid='search-form']
${SEL_SEARCH_ORIGIN}          css:[data-testid='search-origin']
${SEL_SEARCH_DESTINATION}     css:[data-testid='search-destination']
${SEL_SEARCH_STATUS}          css:[data-testid='search-status']
${SEL_BTN_SEARCH_SUBMIT}      css:[data-testid='btn-search-submit']
${SEL_BTN_SEARCH_RESET}       css:[data-testid='btn-search-reset']
${SEL_SEARCH_RESULTS}         css:[data-testid='search-results']
${SEL_SEARCH_RESULT_ITEM}     css:[data-testid='search-result-item']
${SEL_SEARCH_RESULT_STATUS}   css:[data-testid='search-result-status']
${SEL_SEARCH_FLIGHT_LINK}     css:[data-testid='search-flight-link']
${SEL_SEARCH_INITIAL_STATE}   css:[data-testid='search-initial-state']
${SEL_SEARCH_NO_RESULTS}      css:[data-testid='search-no-results']
${SEL_PAGE_TITLE_SEARCH}      css:[data-testid='page-title-search']

# Selectors — Passenger Profile
${SEL_PASSENGER_HEADER}          css:[data-testid='passenger-header']
${SEL_PASSENGER_DETAIL_GRID}     css:[data-testid='passenger-detail-grid']
${SEL_DETAIL_FIRST}              css:[data-testid='detail-first']
${SEL_DETAIL_LAST}               css:[data-testid='detail-last']
${SEL_DETAIL_EMAIL}              css:[data-testid='detail-email']
${SEL_DETAIL_PASSPORT}           css:[data-testid='detail-passport']
${SEL_DETAIL_SEAT_CLASS}         css:[data-testid='detail-seat-class']
${SEL_DETAIL_SEAT_NUMBER}        css:[data-testid='detail-seat-number']
${SEL_PASSENGER_FLIGHTS_LIST}    css:[data-testid='passenger-flights-list']
${SEL_PASSENGER_FLIGHT_ITEM}     css:[data-testid='passenger-flight-item']
${SEL_PASSENGER_FLIGHT_LINK}     css:[data-testid='passenger-flight-link']
${SEL_BTN_REMOVE_FLIGHT}         css:[data-testid='btn-remove-flight']
${SEL_NO_FLIGHTS}                css:[data-testid='no-flights']

# Selectors — Users
${SEL_PAGE_TITLE_FLIGHTS_ID}     css:[id='page-title-flights']

# Test Data — Passengers
${PASSENGER_FIRST_ECONOMY}       John
${PASSENGER_LAST_ECONOMY}        Doe
${PASSENGER_EMAIL_ECONOMY}       john@test.com
${PASSENGER_PASSPORT_ECONOMY}    JD123456

${PASSENGER_FIRST_BUSINESS}      Jane
${PASSENGER_LAST_BUSINESS}       Smith
${PASSENGER_EMAIL_BUSINESS}      jane@test.com
${PASSENGER_PASSPORT_BUSINESS}   JS123456

${PASSENGER_FIRST_FIRST}         James
${PASSENGER_LAST_FIRST}          Bond
${PASSENGER_EMAIL_FIRST}         james@test.com
${PASSENGER_PASSPORT_FIRST}      JB123456

# Test Data — Airports
${AIRPORT_JFK}    New York City (JFK)
${AIRPORT_LHR}    London (LHR)
