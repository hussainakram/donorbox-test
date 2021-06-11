
$(document).on("turbolinks:load", () => {
  $(".js-search-tasks").each((_, element) => {
    const searchByDropdown = $(element).find('.js-search-by-dropdown');
    const statusDropdwon = $(element).find('.js-status-dropdown');
    const searchInput = $(element).find('.js-query-input');
    const createdAtInput = $(element).find('.js-date-input');
    const searchSubmitBtn = $(element).find('.js-search-btn');
    const errorBox = $(element).find('.js-error-msg')
    let currentQueryInput = searchInput;

    const submitSearch = () => {
      const searchBy = searchByDropdown.val();
      const query = currentQueryInput.val();

      $.ajax({
        url: '/tasks',
        type: 'get',
        dataType: 'script',
        data: {
          search_by: searchBy,
          query: query
        },
        error: (data) => {
          errorBox.text('Something went wrong!');
        }
      });
    }

    const resetInputFields = () => {
      searchInput.val('');
      statusDropdwon.val('');
      createdAtInput.val('');
    }

    searchSubmitBtn.on('click', submitSearch);
    searchInput.on('keypress', (e) => {
      if (e.which === 13) submitSearch();
    });


    searchByDropdown.on('change', () => {
      resetInputFields();
      const searchByValue = searchByDropdown.val();

      if (searchByValue === 'status') {
        searchInput.addClass('hidden');
        createdAtInput.addClass('hidden');
        statusDropdwon.removeClass('hidden');
        currentQueryInput = statusDropdwon;

      } else if (searchByValue === 'created_at') {
        statusDropdwon.addClass('hidden');
        searchInput.addClass('hidden');
        createdAtInput.removeClass('hidden');
        currentQueryInput = createdAtInput;

      } else if (searchByValue === 'title') {
        statusDropdwon.addClass('hidden');
        createdAtInput.addClass('hidden');
        searchInput.removeClass('hidden');
        currentQueryInput = searchInput;
      }
    });
  })
});
