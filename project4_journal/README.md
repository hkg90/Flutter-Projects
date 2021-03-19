# Journal Application

Program enables user to view existing journal entries in a list, view a single journal entry, add a new journal entry and change and remember selected application theme from light or dark (stores user preference). The theme preferences and journal data persist between application restarts. Based on the amount of horizontal space available on the screen the app renders the regular journal list as one list or two lists (regular journal list + master journal list). The functional components of app:

  * Displays a "Welcome" widget when the application starts and there are 0 journal entries.
  * Provides the user, via a button in the right of the AppBar, with a toggle-able configuration option, presented in a Drawer, to change the theme from light to dark.
  * Changing the configuration immediately changes the visual theme of the app.
  * The configuration preference persist between application restarts and are honored when the user starts the application.
  * When no prior saved preference exists, uses the light theme.
  * When the application starts, loads the saved theme configuration, and immediately use it when creating the MaterialApp.
  * Models a journal consisting of journal entries. A JournalEntry object has an id (an integer), title (a string), body (a string), rating (an integer), and date (a DateTime).
  * Displays a list of existing journal entries, by displaying the title and date of the journal entry.
  * Displays the details of the journal entry, including its title, body, date and numeric rating, when tapped on in the list.
  * Enables the user to go "back" to the list when viewing the details of a journal entry full-screen.
  * Adapts the interface to display the list of journal entries on the left, and the details of the entry on the right (in a "master-detail" layout convention) when the device has at least X (you can change and specify as desired) pixels of horizontal space.
  * Displays a FloatingActionButton that, when tapped, displays a form for entering attributes of a new journal entry.
  * Validates the values in the form, ensuring that the title and body are not blank, and that the rating is an integer between 1 and 4.
  * Creates a new journal entry when the form's "Save" button is tapped, and return to the previous screen
  * Ensures that new journal entries appear in the list after the form's "Save" button is tapped.
  * Ensures that previously-created journal entries appear in the list when the application first starts.
