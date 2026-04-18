*** Settings ***
Documentation    Centralized variables for URLs, selectors and test data.


*** Variables ***
# ── URLs ────────────────────────────────────────────────────────────────────
${BASE_URL}              http://127.0.0.1:8000
${FLIGHTS_URL}           ${BASE_URL}/flights/
${SEARCH_URL}            ${BASE_URL}/flights/search/
${DASHBOARD_URL}         ${BASE_URL}/flights/dashboard/
${LOGIN_URL}             ${BASE_URL}/users/login
${LOGOUT_URL}            ${BASE_URL}/users/logout
${REGISTER_URL}          ${BASE_URL}/users/register
${INVALID_FLIGHT_URL}    ${BASE_URL}/flights/999/

# ── Timeouts ─────────────────────────────────────────────────────────────────
${SHORT_TIMEOUT}         5s
${DEFAULT_TIMEOUT}       10s
${LONG_TIMEOUT}          30s

# ── Admin Credentials ────────────────────────────────────────────────────────
${ADMIN_USER}            anasse
${ADMIN_PASS}            anasse

# ── Test User Credentials ────────────────────────────────────────────────────
${TEST_USER}             testuser
${TEST_PASS}             testpass123
${TEST_EMAIL}            testuser@test.com

# ── Selectors — Topbar ───────────────────────────────────────────────────────
${SEL_TOPBAR}                css:[data-testid='topbar']
${SEL_TOPBAR_BRAND}          css:[data-testid='topbar-brand']
${SEL_BTN_LOGOUT}            css:[data-testid='btn-logout']
${SEL_BTN_LOGIN_NAV}         css:[data-testid='btn-login']

# ── Selectors — Auth ─────────────────────────────────────────────────────────
${SEL_INPUT_USERNAME}        css:[data-testid='input-username']
${SEL_INPUT_PASSWORD}        css:[data-testid='input-password']
${SEL_BTN_SIGNIN}            css:[data-testid='btn-signin']
${SEL_LINK_REGISTER}         css:[data-testid='link-register']
${SEL_LINK_LOGIN}            css:[data-testid='link-login']
${SEL_INPUT_REG_USERNAME}    css:[data-testid='input-reg-username']
${SEL_INPUT_REG_EMAIL}       css:[data-testid='input-reg-email']
${SEL_INPUT_REG_PASSWORD}    css:[data-testid='input-reg-password']
${SEL_INPUT_REG_PASSWORD2}   css:[data-testid='input-reg-password2']
${SEL_BTN_REGISTER}          css:[data-testid='btn-register']
${SEL_REGISTER_ERROR}        css:[data-testid='register-error']

# ── Selectors — Index ────────────────────────────────────────────────────────
${SEL_PAGE_TITLE_FLIGHTS}    css:[data-testid='page-title-flights']
${SEL_STATS_BAR}             css:[data-testid='stats-bar']
${SEL_FLIGHT_TABLE}          css:[data-testid='flight-table']
${SEL_FLIGHT_ROW}            css:[data-testid='flight-row']
${SEL_FLIGHT_LINK}           css:[data-test='flight-details-link']
${SEL_FILTER_ORIGIN}         css:[data-testid='filter-origin']
${SEL_FILTER_DESTINATION}    css:[data-testid='filter-destination']
${SEL_FILTER_STATUS}         css:[data-testid='filter-status']
${SEL_FILTER_DATE}           css:[data-testid='filter-date']
${SEL_BTN_FILTER_RESET}      css:[data-testid='btn-filter-reset']
${SEL_BTN_PERIOD_TODAY}      css:[data-testid='btn-period-today']
${SEL_BTN_PERIOD_WEEK}       css:[data-testid='btn-period-week']
${SEL_BTN_PERIOD_MONTH}      css:[data-testid='btn-period-month']
${SEL_PAGINATION_INFO}       css:[data-testid='pagination-info']
${SEL_BTN_PAGE_NEXT}         css:[data-testid='btn-page-next']
${SEL_BTN_PAGE_PREV}         css:[data-testid='btn-page-prev']

# ── Selectors — Flight Detail ─────────────────────────────────────────────────
${SEL_FLIGHT_HEADER}         css:[id='flight-header']
${SEL_DETAIL_ORIGIN}         css:[id='detail-origin']
${SEL_DETAIL_DESTINATION}    css:[id='detail-destination']
${SEL_DETAIL_DURATION}       css:[id='detail-duration']
${SEL_DETAIL_STATUS}         css:[data-testid='detail-status']
${SEL_DETAIL_CAPACITY}       css:[data-testid='detail-capacity']
${SEL_PASSENGER_COUNT}       css:[data-testid='passenger-count']
${SEL_STATUS_FORM}           css:[data-testid='status-form']
${SEL_STATUS_SELECT}         css:[data-testid='status-select']
${SEL_BTN_UPDATE_STATUS}     css:[data-testid='btn-update-status']
${SEL_NO_STATUS_TRANSITION}  css:[data-testid='no-status-transition']
${SEL_BOOKING_DISABLED}      css:[data-testid='booking-disabled']
${SEL_BTN_BOOK_SEAT}         css:[data-testid='btn-book-seat']

# ── Selectors — Passenger List ───────────────────────────────────────────────
${SEL_PASSENGER_LIST}        css:[data-testid='passenger-list']
${SEL_PASSENGER_ITEM}        css:[data-testid='passenger-item']
${SEL_PASSENGER_NAME}        css:[data-testid='passenger-name']
${SEL_PASSENGER_SEAT}        css:[data-testid='passenger-seat']
${SEL_PASSENGER_CLASS}       css:[data-testid='passenger-class']
${SEL_PASSENGER_EMAIL}       css:[data-testid='passenger-email']
${SEL_PASSENGER_PASSPORT}    css:[data-testid='passenger-passport']
${SEL_BTN_REMOVE}            css:[data-testid='btn-remove']
${SEL_NO_PASSENGERS}         css:[data-testid='no-passengers']

# ── Selectors — Add Passenger Modal ──────────────────────────────────────────
${SEL_BTN_OPEN_MODAL}        css:[data-testid='btn-open-add-passenger']
${SEL_MODAL}                 css:[data-testid='modal-add-passenger']
${SEL_INPUT_FIRST}           css:[data-testid='input-first']
${SEL_INPUT_LAST}            css:[data-testid='input-last']
${SEL_INPUT_EMAIL}           css:[data-testid='input-email']
${SEL_INPUT_PASSPORT}        css:[data-testid='input-passport']
${SEL_INPUT_SEAT_CLASS}      css:[data-testid='input-seat-class']
${SEL_BTN_CONFIRM}           css:[data-testid='btn-confirm-add-passenger']
${SEL_BTN_CANCEL_MODAL}      css:[data-testid='btn-cancel-modal']
${SEL_BOOKING_ERROR}         css:[data-testid='booking-error']

# ── Selectors — Seat Map ─────────────────────────────────────────────────────
${SEL_PAGE_TITLE_SEAT_MAP}   css:[data-testid='page-title-seat-map']
${SEL_CABIN_FIRST}           css:[data-testid='cabin-section-FIRST']
${SEL_CABIN_BUSINESS}        css:[data-testid='cabin-section-BUSINESS']
${SEL_CABIN_ECONOMY}         css:[data-testid='cabin-section-ECONOMY']
${SEL_PRICE_FIRST}           css:[data-testid='price-FIRST']
${SEL_PRICE_BUSINESS}        css:[data-testid='price-BUSINESS']
${SEL_PRICE_ECONOMY}         css:[data-testid='price-ECONOMY']
${SEL_OCCUPANCY_INDICATOR}   css:[data-testid='occupancy-indicator']

# ── Selectors — Booking ──────────────────────────────────────────────────────
${SEL_PAGE_TITLE_CONFIRM}    css:[data-testid='page-title-booking-confirm']
${SEL_CONFIRM_FORM}          css:[data-testid='booking-confirm-form']
${SEL_INPUT_CONFIRM_FIRST}   css:[data-testid='input-confirm-first']
${SEL_INPUT_CONFIRM_LAST}    css:[data-testid='input-confirm-last']
${SEL_INPUT_CONFIRM_EMAIL}   css:[data-testid='input-confirm-email']
${SEL_INPUT_CONFIRM_PASSPORT}     css:[data-testid='input-confirm-passport']
${SEL_BTN_CONFIRM_BOOKING}   css:[data-testid='btn-confirm-booking']
${SEL_BTN_CANCEL_BOOKING}    css:[data-testid='btn-cancel-booking']
${SEL_CONFIRM_PRICE}         css:[data-testid='confirm-price']
${SEL_PAGE_TITLE_SUCCESS}    css:[data-testid='page-title-booking-success']
${SEL_BOOKING_REFERENCE}     css:[data-testid='booking-reference']
${SEL_BTN_DOWNLOAD_BP}       css:[data-testid='btn-download-boarding-pass']
${SEL_SUCCESS_PRICE}         css:[data-testid='success-price']

# ── Selectors — Passenger Profile ────────────────────────────────────────────
${SEL_PASSENGER_HEADER}      css:[data-testid='passenger-header']
${SEL_DETAIL_EMAIL}          css:[data-testid='detail-email']
${SEL_DETAIL_PASSPORT}       css:[data-testid='detail-passport']
${SEL_DETAIL_SEAT_CLASS}     css:[data-testid='detail-seat-class']
${SEL_DETAIL_SEAT_NUMBER}    css:[data-testid='detail-seat-number']
${SEL_PASSENGER_FLIGHTS}     css:[data-testid='passenger-flights-list']
${SEL_BTN_REMOVE_FLIGHT}     css:[data-testid='btn-remove-flight']
${SEL_NO_FLIGHTS}            css:[data-testid='no-flights']

# ── Selectors — Search ───────────────────────────────────────────────────────
${SEL_PAGE_TITLE_SEARCH}     css:[data-testid='page-title-search']
${SEL_SEARCH_FORM}           css:[data-testid='search-form']
${SEL_SEARCH_ORIGIN}         css:[data-testid='search-origin']
${SEL_SEARCH_DESTINATION}    css:[data-testid='search-destination']
${SEL_SEARCH_STATUS}         css:[data-testid='search-status']
${SEL_SEARCH_DATE}           css:[data-testid='search-date']
${SEL_BTN_SEARCH_SUBMIT}     css:[data-testid='btn-search-submit']
${SEL_BTN_SEARCH_RESET}      css:[data-testid='btn-search-reset']
${SEL_SEARCH_RESULTS}        css:[data-testid='search-results']
${SEL_SEARCH_RESULT_ITEM}    css:[data-testid='search-result-item']
${SEL_SEARCH_FLIGHT_LINK}    css:[data-testid='search-flight-link']
${SEL_SEARCH_NO_RESULTS}     css:[data-testid='search-no-results']
${SEL_SEARCH_INITIAL_STATE}  css:[data-testid='search-initial-state']

# ── Selectors — Dashboard ────────────────────────────────────────────────────
${SEL_PAGE_TITLE_DASHBOARD}  css:[data-testid='page-title-dashboard']
${SEL_KPI_GRID}              css:[data-testid='kpi-grid']
${SEL_KPI_TOTAL_FLIGHTS}     css:[data-testid='kpi-total-flights']
${SEL_KPI_TOTAL_PAX}         css:[data-testid='kpi-total-passengers']
${SEL_KPI_AVG_OCC}           css:[data-testid='kpi-avg-occupancy']
${SEL_KPI_REVENUE}           css:[data-testid='kpi-total-revenue']
${SEL_TODAY_BAR}             css:[data-testid='today-bar']
${SEL_TODAY_TOTAL}           css:[data-testid='today-total']
${SEL_TABLE_TOP_ROUTES}      css:[data-testid='table-top-routes']

# ── Test Data — Passengers ───────────────────────────────────────────────────
${PASSENGER_FIRST_ECONOMY}      John
${PASSENGER_LAST_ECONOMY}       Doe
${PASSENGER_EMAIL_ECONOMY}      john@test.com
${PASSENGER_PASSPORT_ECONOMY}   JD123456

${PASSENGER_FIRST_BUSINESS}     Jane
${PASSENGER_LAST_BUSINESS}      Smith
${PASSENGER_EMAIL_BUSINESS}     jane@test.com
${PASSENGER_PASSPORT_BUSINESS}  JS123456

${PASSENGER_FIRST_FIRST}        James
${PASSENGER_LAST_FIRST}         Bond
${PASSENGER_EMAIL_FIRST}        james@test.com
${PASSENGER_PASSPORT_FIRST}     JB123456

# ── Test Data — Airports ─────────────────────────────────────────────────────
${AIRPORT_JFK}    New York City (JFK)
${AIRPORT_LHR}    London (LHR)
${AIRPORT_CDG}    Paris (CDG)

# ── Test Data — Dates ────────────────────────────────────────────────────────
${DATE_EXISTING}      2026-04-20
${DATE_NO_RESULT}     2020-01-01
