// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get onboardingTitle => 'Benvenuti a Bloomee';

  @override
  String get onboardingSubtitle => 'Organizziamo la tua lingua e la tua regione.';

  @override
  String get continueButton => 'Continua';

  @override
  String get navHome => 'Home';

  @override
  String get navLibrary => 'Biblioteca';

  @override
  String get navSearch => 'Ricerca';

  @override
  String get navLocal => 'Locale';

  @override
  String get navOffline => 'Offline';

  @override
  String get playerEnjoyingFrom => 'Divertimento da';

  @override
  String get playerQueue => 'Coda';

  @override
  String get playerPlayWithMix => 'Auto-Mix Play';

  @override
  String get playerPlayNext => 'Riproduci successivo';

  @override
  String get playerAddToQueue => 'Aggiungi a Queue';

  @override
  String get playerAddToFavorites => 'Aggiungi ai Preferiti';

  @override
  String get playerNoLyricsFound => 'Nessun testo trovato';

  @override
  String get playerLyricsNoPlugin => 'Nessun fornitore di testi configurato. Vai a Impostazioni → Plugin per installarne uno.';

  @override
  String get playerFullscreenLyrics => 'Lirica a schermo intero';

  @override
  String get localMusicTitle => 'Locale';

  @override
  String get localMusicGrantPermission => 'Permesso di concessione';

  @override
  String get localMusicStorageAccessRequired => 'Deposito di accesso richiesto';

  @override
  String get localMusicStorageAccessDesc => 'Si prega di concedere il permesso di eseguire la scansione e riprodurre file audio memorizzati sul dispositivo.';

  @override
  String get localMusicAddFolder => 'Aggiungi cartella musicale';

  @override
  String get localMusicScanNow => 'Scansiona ora';

  @override
  String localMusicScanFailed(String message) {
    return 'Scansione non riuscita: $message';
  }

  @override
  String get localMusicScanning => 'Dispositivo di scansione per file audio...';

  @override
  String get localMusicEmpty => 'Nessuna musica locale trovata';

  @override
  String get localMusicSearchEmpty => 'Nessuna traccia trovata in corrispondenza della tua ricerca.';

  @override
  String get localMusicShuffle => 'Shuffle';

  @override
  String get localMusicPlayAll => 'Riproduci tutto';

  @override
  String get localMusicSearchHint => 'Cerca musica locale...';

  @override
  String get localMusicRescanDevice => 'Esegui nuova scansione del dispositivo';

  @override
  String get localMusicRemoveFolder => 'Rimuovere la cartella';

  @override
  String get localMusicMusicFolders => 'Cartelle musicali';

  @override
  String localMusicTrackCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tracce',
      one: '1 traccia',
    );
    return '$_temp0';
  }

  @override
  String get buttonCancel => 'Annullamento';

  @override
  String get buttonDelete => 'Cancella';

  @override
  String get buttonOk => 'Va bene.';

  @override
  String get buttonUpdate => 'Aggiornamento';

  @override
  String get buttonDownload => 'Scarica';

  @override
  String get buttonShare => 'Condividi';

  @override
  String get buttonLater => 'Più tardi.';

  @override
  String get buttonInfo => 'Info';

  @override
  String get buttonMore => 'Altro';

  @override
  String get dialogDeleteTrack => 'Eliminare la traccia';

  @override
  String dialogDeleteTrackMessage(String title) {
    return 'Sei sicuro di voler eliminare "$title" dal tuo dispositivo? Questa azione non può essere annullata.';
  }

  @override
  String get dialogDeleteTrackLinkedPlaylists => 'Questa traccia sarà anche rimossa da:';

  @override
  String get dialogDontAskAgain => 'Non chiedermelo di nuovo.';

  @override
  String get dialogDeletePlugin => 'Elimina Plugin?';

  @override
  String dialogDeletePluginMessage(String name) {
    return 'Sei sicuro di voler eliminare "$name"? Questo rimuoverà permanentemente i suoi file.';
  }

  @override
  String get dialogUpdateAvailable => 'Aggiornamento disponibile';

  @override
  String get dialogUpdateNow => 'Aggiorna ora';

  @override
  String get dialogDownloadPlaylist => 'Scarica playlist';

  @override
  String dialogDownloadPlaylistMessage(int count, String title) {
    return 'Vuoi effettuare il download di $count brani da "$title"? Verranno aggiunti alla coda download.';
  }

  @override
  String get dialogDownloadAll => 'Scarica tutti';

  @override
  String get playlistEdit => 'Modifica della lista dei giochi';

  @override
  String get playlistShareFile => 'Condividere il file';

  @override
  String get playlistExportFile => 'Esporta file';

  @override
  String get playlistPlay => 'Gioca';

  @override
  String get playlistAddToQueue => 'Aggiungi Playlist a Queue';

  @override
  String get playlistShare => 'Condividi Playlist';

  @override
  String get playlistDelete => 'Eliminare la lista dei giochi';

  @override
  String get playlistEmptyState => 'Ancora nessuna canzone!';

  @override
  String get playlistAvailableOffline => 'Disponibile Offline';

  @override
  String get playlistShuffle => 'Shuffle';

  @override
  String get playlistMoreOptions => 'Altre opzioni';

  @override
  String get playlistNoMatchSearch => 'No playlists corrisponde alla tua ricerca';

  @override
  String get playlistCreateNew => 'Crea una nuova playlist 😍';

  @override
  String get playlistCreateFirstOne => 'No playlists ancora. Creare uno per iniziare!';

  @override
  String get addToPlaylistNoSongSelected => 'Nessuna canzone selezionata';

  @override
  String get createPlaylistDialogBarrierLabel => 'Creare playlist dialogo';

  @override
  String get createPlaylistDialogNameHint => 'Vibrazioni estive';

  @override
  String get createPlaylistDialogCreate => 'Creare';

  @override
  String playlistSongCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count brani',
      one: '1 brano',
    );
    return '$_temp0';
  }

  @override
  String playlistRemovedTrack(String title, String playlist) {
    return '$title rimosso da $playlist';
  }

  @override
  String get playlistFailedToLoad => 'Non caricate playlist';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsPlugins => 'Plugin';

  @override
  String get settingsPluginsSubtitle => 'Installare, caricare e gestire plugin.';

  @override
  String get settingsUpdates => 'Aggiornamenti';

  @override
  String get settingsUpdatesSubtitle => 'Controllare i nuovi aggiornamenti';

  @override
  String get settingsDownloads => 'Downloads';

  @override
  String get settingsDownloadsSubtitle => 'Scarica Path, Scarica Qualità e altro ancora...';

  @override
  String get settingsLocalTracks => 'Tracce locali';

  @override
  String get settingsLocalTracksSubtitle => 'Scansione, gestione di cartelle e impostazioni di auto-scan.';

  @override
  String get settingsPlayer => 'Impostazioni del giocatore';

  @override
  String get settingsPlayerSubtitle => 'Qualità della corrente, Gioco automatico, ecc.';

  @override
  String get settingsPluginDefaults => 'Predefiniti del plugin';

  @override
  String get settingsPluginDefaultsSubtitle => 'Scopri la fonte, la priorità del risolutore.';

  @override
  String get settingsUIElements => 'Elementi e servizi dell\'interfaccia utente';

  @override
  String get settingsUIElementsSubtitle => 'Scivolo automatico, UI tweaks ecc.';

  @override
  String get settingsLastFM => 'Impostazioni Last.FM';

  @override
  String get settingsLastFMSubtitle => 'API Impostazioni Key, Secret e Scrobbling.';

  @override
  String get settingsStorage => 'Stoccaggio';

  @override
  String get settingsStorageSubtitle => 'Backup, Cache, Storia, Ripristino e altro ancora...';

  @override
  String get settingsLanguageCountry => 'Lingua & Paese';

  @override
  String get settingsLanguageCountrySubtitle => 'Selezionare la lingua e il paese.';

  @override
  String get settingsAbout => 'A proposito di';

  @override
  String get settingsAboutSubtitle => 'Informazioni sull\'app, versione, sviluppatore, ecc.';

  @override
  String get settingsScanning => 'Scansione';

  @override
  String get settingsMusicFolders => 'Cartelle musicali';

  @override
  String get settingsQuality => 'Qualità';

  @override
  String get settingsHistory => 'Storia';

  @override
  String get settingsBackupRestore => 'Backup & Ripristino';

  @override
  String get settingsAutomatic => 'Automatico';

  @override
  String get settingsDangerZone => 'Zona di pericolo';

  @override
  String get settingsScrobbling => 'Scrobbling';

  @override
  String get settingsAuthentication => 'Autenticazione';

  @override
  String get settingsHomeScreen => 'Schermo di casa';

  @override
  String get settingsChartVisibility => 'Visibilità del grafico';

  @override
  String get settingsLocation => 'Location';

  @override
  String get pluginRepositoryTitle => 'Repository plugin';

  @override
  String get pluginRepositorySubtitle => 'Aggiungi una sorgente JSON per navigare in remoto plugin.';

  @override
  String get pluginRepositoryAddAction => 'Aggiungi repository';

  @override
  String get pluginRepositoryAddTitle => 'Aggiungi repository';

  @override
  String get pluginRepositoryAddSubtitle => 'Inserisci l\'URL di un file JSON valido plugin repository.';

  @override
  String get pluginRepositoryEmpty => 'Non sono ancora stati aggiunti i repository.';

  @override
  String get pluginRepositoryUrlCopied => 'URL di repository copiato su clipboard';

  @override
  String get pluginRepositoryNoDescription => 'Nessuna descrizione fornita.';

  @override
  String get pluginRepositoryUnknownUpdate => 'Aggiornamento sconosciuto';

  @override
  String pluginRepositoryPluginsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plugin',
      one: '1 plugin',
    );
    return '$_temp0';
  }

  @override
  String get pluginRepositoryErrorLoad => 'Non sono riuscito a caricare i repository.';

  @override
  String get pluginRepositoryErrorInvalid => 'URL di archivio non valido o file di repository.';

  @override
  String get pluginRepositoryErrorRemove => 'Non è riuscito a rimuovere il repository.';

  @override
  String pluginRepositoryError(String message) {
    return 'Errore: $message';
  }

  @override
  String get dialogAddingToDownloadQueue => 'Aggiunta di download';

  @override
  String get emptyNoInternet => 'Nessuna connessione Internet!';

  @override
  String get emptyNoContentPlugin => 'Nessun contenuto plugin caricato. Caricare un Content Resolver in Plugin Manager.';

  @override
  String get emptyRefreshingSource => 'Refreshing Discover source... La fonte precedente non è più disponibile.';

  @override
  String get emptyNoTracks => 'Nessuna traccia disponibile';

  @override
  String get emptyNoResults => 'Nessuna corrispondenza trovata';

  @override
  String snackbarDeletedTrack(String title) {
    return 'Eliminato "$title"';
  }

  @override
  String snackbarDeleteFailed(String title) {
    return 'Impossibile eliminare "$title"';
  }

  @override
  String get snackbarAddedToNextQueue => 'Aggiunto al Successivo in Queue';

  @override
  String get snackbarAddedToQueue => 'Aggiunto a Queue';

  @override
  String snackbarAddedToLiked(String title) {
    return '$title è stato aggiunto ai Preferiti!!';
  }

  @override
  String snackbarNowPlaying(String name) {
    return 'Riproduzione di $name';
  }

  @override
  String snackbarPlaylistAddedToQueue(String name) {
    return 'Aggiunto $name alla coda';
  }

  @override
  String get snackbarPlaylistQueued => 'Lista di riproduzione aggiunta a download coda';

  @override
  String get snackbarPlaylistUpdated => 'Lista dei giochi Aggiornato!';

  @override
  String get snackbarNoInternet => 'Nessuna connessione internet.';

  @override
  String get snackbarImportFailed => 'Importazione fallita!';

  @override
  String get snackbarImportCompleted => 'Importazione completata';

  @override
  String get snackbarBackupFailed => 'Il backup non è riuscito!';

  @override
  String snackbarExportedTo(String path) {
    return 'Esportato in: $path';
  }

  @override
  String get snackbarMediaIdCopied => 'Media ID copiato';

  @override
  String get snackbarLinkCopied => 'Link copiato';

  @override
  String get snackbarNoLinkAvailable => 'No link disponibile';

  @override
  String get snackbarCouldNotOpenLink => 'Non si può aprire';

  @override
  String snackbarPreparingDownload(String title) {
    return 'Preparazione download per $title...';
  }

  @override
  String snackbarAlreadyDownloaded(String title) {
    return '$title è già stato scaricato.';
  }

  @override
  String snackbarAlreadyInQueue(String title) {
    return '$title è già nella coda.';
  }

  @override
  String snackbarDownloaded(String title) {
    return 'Scaricato $title';
  }

  @override
  String get snackbarDownloadServiceUnavailable => 'Errore: il servizio di download non è disponibile.';

  @override
  String snackbarSongsAddedToQueue(int count) {
    return 'Aggiunti $count brani alla coda download';
  }

  @override
  String get snackbarDeleteTrackFailDevice => 'Non è riuscito a eliminare la traccia dall\'archiviazione del dispositivo.';

  @override
  String get searchHintExplore => 'Cosa vuoi ascoltare?';

  @override
  String get searchHintLibrary => 'Ricerca biblioteca...';

  @override
  String get searchHintOfflineMusic => 'Cerca le tue canzoni...';

  @override
  String get searchHintPlaylists => 'Cercate...';

  @override
  String get searchStartTyping => 'Inizia a digitare per cercare...';

  @override
  String get searchNoSuggestions => 'Nessun suggerimento trovato!';

  @override
  String get searchNoResults => 'Nessun risultato trovato! Prova un\'altra parola chiave o fonte.';

  @override
  String get searchFailed => 'La ricerca è fallita!';

  @override
  String get searchDiscover => 'Scopri la musica incredibile...';

  @override
  String get searchSources => 'SORGENTI';

  @override
  String get searchNoPlugins => 'No plugin installato';

  @override
  String get searchTracks => 'Tracce';

  @override
  String get searchAlbums => 'Album';

  @override
  String get searchArtists => 'Artisti';

  @override
  String get searchPlaylists => 'liste di gioco';

  @override
  String get exploreDiscover => 'Scopri di più';

  @override
  String get exploreRecently => 'Recentemente';

  @override
  String get exploreLastFmPicks => 'Scelte Last.FM';

  @override
  String get exploreFailedToLoad => 'Non è riuscito a caricare le sezioni di casa.';

  @override
  String get libraryTitle => 'Biblioteca';

  @override
  String get libraryEmptyState => 'La tua biblioteca si sente sola, aggiungi qualche canzone per illuminarla!';

  @override
  String libraryIn(String playlistName) {
    return 'in $playlistName';
  }

  @override
  String get menuAddToPlaylist => 'Aggiungi alla lista dei giochi';

  @override
  String get menuSmartReplace => 'Sostituire Smart';

  @override
  String get menuShare => 'Condividi';

  @override
  String get menuAvailableOffline => 'Disponibile Offline';

  @override
  String get menuDownload => 'Scarica';

  @override
  String get menuOpenOriginalLink => 'Aperto originale link';

  @override
  String get menuDeleteTrack => 'Cancella';

  @override
  String get songInfoTitle => 'Titolo';

  @override
  String get songInfoArtist => 'Artista';

  @override
  String get songInfoAlbum => 'Album';

  @override
  String get songInfoMediaId => 'ID dei media';

  @override
  String get songInfoCopyId => 'Copia ID';

  @override
  String get songInfoCopyLink => 'Copia Link';

  @override
  String get songInfoOpenBrowser => 'Aprire a browser';

  @override
  String get tooltipRemoveFromLibrary => 'Rimuovi dalla Libreria';

  @override
  String get tooltipSaveToLibrary => 'Salva nella Biblioteca';

  @override
  String get tooltipOpenOriginalLink => 'Apri il link originale';

  @override
  String get tooltipShuffle => 'Shuffle';

  @override
  String get tooltipAvailableOffline => 'Disponibile Offline';

  @override
  String get tooltipDownloadPlaylist => 'Scarica playlist';

  @override
  String get tooltipMoreOptions => 'Altre opzioni';

  @override
  String get tooltipInfo => 'Info';

  @override
  String get appuiTitle => 'UI e Servizi';

  @override
  String get appuiAutoSlideCharts => 'Carte di scorrimento auto';

  @override
  String get appuiAutoSlideChartsSubtitle => 'Scorrere i grafici automaticamente nella schermata iniziale.';

  @override
  String get appuiLastFmPicksSubtitle => 'Mostra suggerimenti da Last.FM. Login e riavviare richiesto.';

  @override
  String get appuiNoChartsAvailable => 'Nessun grafico disponibile. Caricare un fornitore di grafici plugin.';

  @override
  String get appuiLoginToLastFm => 'Si prega di effettuare il login per Last.FM prima.';

  @override
  String get appuiShowInCarousel => 'Mostra in casa carosello.';

  @override
  String get countrySettingTitle => 'Paese e lingua';

  @override
  String get countrySettingAutoDetect => 'Rilevamento automatico Paese';

  @override
  String get countrySettingAutoDetectSubtitle => 'Rileva automaticamente il tuo paese quando l\'app si apre.';

  @override
  String get countrySettingCountryLabel => 'Paese';

  @override
  String get countrySettingLanguageLabel => 'Lingua';

  @override
  String get countrySettingSystemDefault => 'Default del sistema';

  @override
  String get downloadSettingTitle => 'Downloads';

  @override
  String get downloadSettingQuality => 'Scarica la Qualità';

  @override
  String get downloadSettingQualitySubtitle => 'Preferenze di qualità audio universale per tracce scaricate.';

  @override
  String get downloadSettingFolder => 'Scarica cartella';

  @override
  String get downloadSettingResetFolder => 'Reimposta la cartella di download';

  @override
  String get downloadSettingResetFolderSubtitle => 'Ripristinare il percorso predefinito download.';

  @override
  String get lastfmTitle => 'Last.FM';

  @override
  String get lastfmScrobbleTracks => 'Scrobble Tracks';

  @override
  String get lastfmScrobbleTracksSubtitle => 'Invia tracce suonate al tuo profilo Last.FM.';

  @override
  String get lastfmAuthFirst => 'Primo Autentico Last.FM API.';

  @override
  String get lastfmAuthenticatedAs => 'Autentico come';

  @override
  String get lastfmAuthFailed => 'Autenticazione fallita:';

  @override
  String get lastfmNotAuthenticated => 'Non autenticata';

  @override
  String get lastfmSteps => 'I passaggi per autenticare: 1. Creare / aprire un account Last.FM alla fine.fm 2. Generare una API key alla fine.fm/api/account/create 3. Inserisci il tuo API Key & Secret sotto 4. Toccare "Start Auth" e approvare nel browser 5. Toccare "Get & Save Session Key" per terminare';

  @override
  String get lastfmApiKey => 'Chiave API';

  @override
  String get lastfmApiSecret => 'Segreto API';

  @override
  String get lastfmStartAuth => '1. Inizio Auth';

  @override
  String get lastfmGetSession => '2. Ottieni & Salva la chiave di sessione';

  @override
  String get lastfmRemoveKeys => 'Rimuovere le chiavi';

  @override
  String get lastfmStartAuthFirst => 'Iniziare prima Auth, poi approvare in browser.';

  @override
  String get localSettingTitle => 'Tracce locali';

  @override
  String get localSettingAutoScan => 'Scansione automatica su Startup';

  @override
  String get localSettingAutoScanSubtitle => 'Scansione automatica di nuove tracce locali quando l\'applicazione inizia.';

  @override
  String get localSettingLastScan => 'Ultimo aggiornamento';

  @override
  String get localSettingNeverScanned => 'Mai.';

  @override
  String get localSettingScanInProgress => 'Scansione in corso...';

  @override
  String get localSettingScanNowSubtitle => 'Attivare manualmente una scansione completa della libreria.';

  @override
  String get localSettingNoFolders => 'Nessuna cartella aggiunta. Aggiungi una cartella per avviare la scansione.';

  @override
  String get localSettingAddFolder => 'Aggiungi cartella';

  @override
  String get playerSettingTitle => 'Impostazioni del giocatore';

  @override
  String get playerSettingStreamingHeader => 'Streaming';

  @override
  String get playerSettingStreamQuality => 'Qualità di streaming';

  @override
  String get playerSettingStreamQualitySubtitle => 'bitrate audio globale per la riproduzione online.';

  @override
  String get playerSettingQualityLow => 'Basso';

  @override
  String get playerSettingQualityMedium => 'Mezzo';

  @override
  String get playerSettingQualityHigh => 'Alto.';

  @override
  String get playerSettingPlaybackHeader => 'Riproduzione';

  @override
  String get playerSettingAutoPlay => 'Riproduzione automatica';

  @override
  String get playerSettingAutoPlaySubtitle => 'Accoda brani simili quando la coda termina.';

  @override
  String get playerSettingAutoFallback => 'Auto Fallback Riproduzione';

  @override
  String get playerSettingAutoFallbackSubtitle => 'Se un plugin manca o non restituisce flussi, prova un risolutore compatibile solo per la riproduzione.';

  @override
  String get playerSettingCrossfade => 'Crossfade';

  @override
  String get playerSettingCrossfadeOff => 'Disattivato';

  @override
  String get playerSettingCrossfadeInstant => 'Tracce commutare istantaneamente';

  @override
  String playerSettingCrossfadeBlend(int seconds) {
    return 'Transizione di ${seconds}s tra le tracce';
  }

  @override
  String get playerSettingEqualizer => 'Equalizzatore';

  @override
  String get playerSettingEqualizerActive => 'Attivo';

  @override
  String playerSettingEqualizerActivePreset(String preset) {
    return 'Abilitato — preset $preset';
  }

  @override
  String get playerSettingEqualizerSubtitle => 'EQ parametrico a 10-band tramite FFmpeg.';

  @override
  String get pluginDefaultsTitle => 'Predefiniti del plugin';

  @override
  String get pluginDefaultsDiscoverHeader => 'Scopri la sorgente';

  @override
  String get pluginDefaultsNoResolver => 'Carica un plugin per scegliere una sorgente Discover.';

  @override
  String get pluginDefaultsAutomaticSubtitle => 'Utilizzare il primo risolutore di contenuti disponibile.';

  @override
  String get pluginDefaultsPriorityHeader => 'Priorità di Risolvenza';

  @override
  String get pluginDefaultsNoPriority => 'Nessun risolutore di contenuti caricati. L\'ordine di priorità apparirà qui una volta che plugin sono caricati.';

  @override
  String get pluginDefaultsPriorityDesc => 'I risolutori di priorità più elevati vengono prima provati quando risolvi gli elementi del grafico o le tracce importate per le tracce giocabili.';

  @override
  String get pluginDefaultsLyricsHeader => 'Priorità dei testi';

  @override
  String get pluginDefaultsLyricsNone => 'Nessun provider di testi caricati.';

  @override
  String get pluginDefaultsLyricsDesc => 'Trascina per riordinare i fornitori di testi. Il primo fornitore è provato prima.';

  @override
  String get pluginDefaultsSuggestionsHeader => 'Cerca Suggerimenti';

  @override
  String get pluginDefaultsSuggestionsNone => 'Nessun provider di suggerimenti caricati.';

  @override
  String get pluginDefaultsSuggestionsHistoryOnlyTitle => 'Nessuno';

  @override
  String get pluginDefaultsSuggestionsHistoryOnlySubtitle => 'Utilizzare la cronologia di ricerca solo.';

  @override
  String get storageSettingTitle => 'Stoccaggio';

  @override
  String get storageClearHistoryEvery => 'Storia chiara in ogni';

  @override
  String get storageClearHistorySubtitle => 'Cancella la storia dell\'ascolto dopo il periodo scelto.';

  @override
  String storageDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '1 giorno',
    );
    return '$_temp0';
  }

  @override
  String get storageBackupLocation => 'Posizione';

  @override
  String get storageBackupLocationAndroid => 'Download / directory app-data';

  @override
  String get storageBackupLocationDownloads => 'Downloads directory';

  @override
  String get storageCreateBackup => 'Crea un backup';

  @override
  String get storageCreateBackupSubtitle => 'Salvare le impostazioni e i dati in un file di backup.';

  @override
  String storageBackupCreatedAt(String path) {
    return 'Backup creato in $path';
  }

  @override
  String storageBackupShareFailed(String error) {
    return 'Impossibile condividere il backup: $error';
  }

  @override
  String get storageBackupFailed => 'Il backup non è riuscito!';

  @override
  String get storageRestoreBackup => 'Ripristinare il backup';

  @override
  String get storageRestoreBackupSubtitle => 'Ripristinare le impostazioni e i dati da un file di backup.';

  @override
  String get storageAutoBackup => 'Backup automatico';

  @override
  String get storageAutoBackupSubtitle => 'Crea automaticamente un backup dei tuoi dati.';

  @override
  String get storageAutoLyrics => 'Risparmiare i testi';

  @override
  String get storageAutoLyricsSubtitle => 'Salvare i testi automaticamente quando una canzone suona.';

  @override
  String get storageResetApp => 'Reset Bloomee App';

  @override
  String get storageResetAppSubtitle => 'Elimina tutti i dati e ripristina l\'app al suo stato predefinito.';

  @override
  String get storageResetConfirmTitle => 'Confermare il ripristino';

  @override
  String get storageResetConfirmMessage => 'Sei sicuro di voler resettare Bloomee? Questo cancellerà tutti i tuoi dati e non potrà essere annullato.';

  @override
  String get storageResetButton => 'Ripristino';

  @override
  String get storageResetSuccess => 'App è stato resettato al suo stato predefinito.';

  @override
  String get storageLocationDialogTitle => 'Posizione';

  @override
  String get storageLocationAndroid => 'I backup sono memorizzati in: 1. Download directory 2. Android/data/ls.bloomee.musicplayer/data Copiare il file da entrambe le posizioni.';

  @override
  String get storageLocationOther => 'I backup sono memorizzati nella directory Downloads. Copiare il file da lì.';

  @override
  String get storageRestoreOptionsTitle => 'Opzioni di ripristino';

  @override
  String get storageRestoreOptionsDesc => 'Scegliere quali dati si desidera ripristinare dal file di backup selezionato. Scelga tutti gli elementi che NON desidera essere importati. Di default tutti sono selezionati.';

  @override
  String get storageRestoreSelectAll => 'Seleziona tutto';

  @override
  String get storageRestoreMediaItems => 'Articoli multimediali (songs, brani, librerie)';

  @override
  String get storageRestoreSearchHistory => 'Storia della ricerca';

  @override
  String get storageRestoreContinue => 'Continua';

  @override
  String get storageRestoreNoFile => 'Nessun file selezionato.';

  @override
  String get storageRestoreSaveFailed => 'Non è riuscito a salvare il file selezionato.';

  @override
  String get storageRestoreConfirmTitle => 'Confermare il ripristino';

  @override
  String get storageRestoreConfirmPrefix => 'Questo sovrascriverà e unirà le parti selezionate nell\'app con i dati del file di backup:';

  @override
  String get storageRestoreConfirmSuffix => 'I tuoi dati attuali verranno modificati/distribuiti. Sei sicuro di voler procedere?';

  @override
  String get storageRestoreYes => 'Sì, restaurare';

  @override
  String get storageRestoreNo => 'No.';

  @override
  String get storageRestoring => 'Ripristino dei dati selezionati... Si prega di attendere che l\'operazione si completa.';

  @override
  String get storageRestoreMediaBullet => '• Articoli multimediali';

  @override
  String get storageRestoreHistoryBullet => '• Storia della ricerca';

  @override
  String get storageUnexpectedError => 'Un errore inaspettato si è verificato durante il ripristino.';

  @override
  String get storageRestoreCompleted => 'Ripristino Completato';

  @override
  String get storageRestoreFailedTitle => 'Ripristino non corretto';

  @override
  String get storageRestoreSuccessMessage => 'I dati selezionati sono stati ripristinati con successo. Per ottenere i migliori risultati, si prega di riavviare l\'app ora.';

  @override
  String get storageRestoreFailedMessage => 'Il processo di ripristino non è riuscito con i seguenti errori:';

  @override
  String get storageRestoreUnknownError => 'Errore sconosciuto si è verificato durante il ripristino.';

  @override
  String get storageRestoreRestartHint => 'Si prega di riavviare l\'app per una migliore consistenza.';

  @override
  String get updateSettingTitle => 'Aggiornamenti';

  @override
  String get updateAppUpdatesHeader => 'Aggiornamenti dell\'app';

  @override
  String get updateCheckForUpdates => 'Controllare gli aggiornamenti';

  @override
  String get updateCheckSubtitle => 'Vedi se è disponibile una versione più recente di Bloomee.';

  @override
  String get updateAutoNotify => 'Aggiornamento automatico';

  @override
  String get updateAutoNotifySubtitle => 'Ricevi notifiche quando i nuovi aggiornamenti sono disponibili all\'inizio dell\'app.';

  @override
  String get updateCheckTitle => 'Controllare gli aggiornamenti';

  @override
  String get updateUpToDate => 'Bloomee🌸 è aggiornato!!!';

  @override
  String get updateViewPreRelease => 'Guarda gli ultimi Pre-Release';

  @override
  String updateCurrentVersion(String curr, String build) {
    return 'Versione attuale: $curr+$build';
  }

  @override
  String get updateNewVersionAvailable => 'La nuova versione di Bloomee🌸 è ora disponibile!!';

  @override
  String updateVersion(String ver, String build) {
    return 'Versione: $ver+$build';
  }

  @override
  String get updateDownloadNow => 'Scarica ora';

  @override
  String get updateChecking => 'Controllare se la versione più recente è disponibile o no!';

  @override
  String get timerTitle => 'Tempo di sonno';

  @override
  String get timerInterludeMessage => 'Prepararsi per un tranquillo interludio in...';

  @override
  String get timerHours => 'Ore';

  @override
  String get timerMinutes => 'Minuti';

  @override
  String get timerSeconds => 'Secondi';

  @override
  String get timerStop => 'Stop Timer';

  @override
  String get timerFinishedMessage => 'I brani hanno riposato. Sogni d\'oro 🥰.';

  @override
  String get timerGotIt => 'Ricevuto!';

  @override
  String get timerSetTimeError => 'Si prega di impostare un tempo';

  @override
  String get timerStart => 'Avviamento timer';

  @override
  String get notificationsTitle => 'Notifiche';

  @override
  String get notificationsEmpty => 'Ancora nessuna Notifica!';

  @override
  String get recentsTitle => 'Storia';

  @override
  String playlistByCreator(String creator) {
    return 'di $creator';
  }

  @override
  String get playlistTypeAlbum => 'Album';

  @override
  String get playlistTypePlaylist => 'Lista dei giochi';

  @override
  String get playlistYou => 'Tu';

  @override
  String get pluginManagerTitle => 'Plugin';

  @override
  String get pluginManagerEmpty => 'No plugin installato. Toccare + per aggiungere un file .bex.';

  @override
  String get pluginManagerFilterAll => 'Tutti';

  @override
  String get pluginManagerFilterContent => 'Risolvere i contenuti';

  @override
  String get pluginManagerFilterCharts => 'Fornitori di grafici';

  @override
  String get pluginManagerFilterLyrics => 'Fornitori di testi';

  @override
  String get pluginManagerFilterSuggestions => 'Fornitori di suggerimenti';

  @override
  String get pluginManagerFilterImporters => 'Importatori di contenuti';

  @override
  String get pluginManagerTooltipRefresh => 'Aggiorna';

  @override
  String get pluginManagerTooltipInstall => 'Installare Plugin';

  @override
  String get pluginManagerNoMatch => 'No plugin abbinare questo filtro';

  @override
  String pluginManagerPickFailed(String error) {
    return 'Impossibile selezionare il file: $error';
  }

  @override
  String get pluginManagerInstalling => 'Installazione plugin...';

  @override
  String get pluginManagerTypeContentResolver => 'Risolvere i contenuti';

  @override
  String get pluginManagerTypeChartProvider => 'Provider di grafici';

  @override
  String get pluginManagerTypeLyricsProvider => 'Fornitore di testi';

  @override
  String get pluginManagerTypeSuggestionProvider => 'Cerca Suggerimenti';

  @override
  String get pluginManagerTypeContentImporter => 'Importatore di contenuti';

  @override
  String get pluginManagerDeleteTitle => 'Elimina Plugin?';

  @override
  String pluginManagerDeleteMessage(String name) {
    return 'Sei sicuro di voler eliminare "$name"? Questo rimuoverà permanentemente i suoi file.';
  }

  @override
  String get pluginManagerDeleteAction => 'Cancella';

  @override
  String get pluginManagerCancel => 'Annullamento';

  @override
  String get pluginManagerEnablePlugin => 'Abilita Plugin';

  @override
  String get pluginManagerUnloadPlugin => 'Disattiva Plugin';

  @override
  String get pluginManagerDeleting => 'Eliminazione...';

  @override
  String get pluginManagerApiKeysTitle => 'Chiavi API';

  @override
  String get pluginManagerApiKeysSaved => 'Chiavi API salvate';

  @override
  String get pluginManagerSave => 'Salva';

  @override
  String get pluginManagerDetailVersion => 'Versione';

  @override
  String get pluginManagerDetailType => 'Tipologia';

  @override
  String get pluginManagerDetailPublisher => 'Editore';

  @override
  String get pluginManagerDetailLastUpdated => 'Ultimo aggiornamento';

  @override
  String get pluginManagerDetailCreated => 'Creato';

  @override
  String get pluginManagerDetailHomepage => 'Pagina iniziale';

  @override
  String get pluginManagerDowngradeTitle => 'Connettore di Downgrade?';

  @override
  String pluginManagerDowngradeMessage(String name) {
    return 'Stai installando una versione precedente o uguale di "$name". Continuare?';
  }

  @override
  String get pluginManagerDowngradeAction => 'Installare in ogni caso';

  @override
  String get pluginManagerDeleteStorageTitle => 'Eliminare Dati Plugin?';

  @override
  String pluginManagerDeleteStorageMessage(String name) {
    return 'Rimuovere anche le API key salvate e le impostazioni per "$name"?';
  }

  @override
  String get pluginManagerDeleteStorageKeep => 'Tenere i dati';

  @override
  String get pluginManagerDeleteStorageRemove => 'Rimuovere i dati';

  @override
  String get segmentsSheetTitle => 'Segmenti';

  @override
  String get segmentsSheetEmpty => 'Nessun segmento disponibile';

  @override
  String get segmentsSheetUntitled => 'Segmento senza titolo';

  @override
  String get smartReplaceTitle => 'Sostituire Smart';

  @override
  String smartReplaceSubtitle(String title) {
    return 'Scegli una sostituzione riproducibile per "$title" e aggiorna i riferimenti salvati nelle playlist.';
  }

  @override
  String get smartReplaceClose => 'Chiudi';

  @override
  String get smartReplaceNoMatch => 'Nessun ricambio trovato';

  @override
  String get smartReplaceNoMatchSubtitle => 'Nessuno dei risolutori caricati plugin ha restituito una partita abbastanza forte.';

  @override
  String get smartReplaceBestMatch => 'Miglior match';

  @override
  String get smartReplaceSearchFailed => 'Ricerca fallita';

  @override
  String smartReplaceApplyFailed(String error) {
    return 'Smart Replace non riuscito: $error';
  }

  @override
  String smartReplaceApplied(String queue) {
    return 'Sostituzione applicata$queue.';
  }

  @override
  String smartReplaceAppliedPlaylists(int count, String plural, String queue) {
    return 'Sostituito in $count playlist$plural$queue.';
  }

  @override
  String get smartReplaceQueueUpdated => 'e aggiornato la coda';

  @override
  String get playerUnknownQueue => 'Sconosciuto';

  @override
  String playerLiked(String title) {
    return '$title aggiunto ai Preferiti!!';
  }

  @override
  String playerUnliked(String title) {
    return '$title rimosso dai Preferiti!!';
  }

  @override
  String get offlineNoDownloads => 'Nessun download';

  @override
  String get offlineTitle => 'Offline';

  @override
  String get offlineSearchHint => 'Cerca le tue canzoni...';

  @override
  String get offlineRefreshTooltip => 'Download di aggiornamento';

  @override
  String get offlineCloseSearch => 'Chiudere la ricerca';

  @override
  String get offlineSearchTooltip => 'Ricerca';

  @override
  String get offlineOpenFailed => 'Incapace di aprire questa pista offline. Prova a rinfrescare downloads.';

  @override
  String get offlinePlayFailed => 'Non è possibile riprodurre questa canzone offline.';

  @override
  String albumViewTrackCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tracce',
      one: '1 traccia',
    );
    return '$_temp0';
  }

  @override
  String get albumViewLoadFailed => 'Non è riuscito a caricare album';

  @override
  String get aboutCraftingSubtitle => 'Creare sinfonie in codice.';

  @override
  String get aboutFollowGitHub => 'Seguilo su GitHub';

  @override
  String get aboutSendInquiry => 'Inviare una richiesta di business';

  @override
  String get aboutCreativeHighlights => 'Aggiornamenti e punti salienti creativi';

  @override
  String get aboutTipQuote => 'Ti piace Bloomee? Una piccola mancia lo fa continuare a fiorire. 🌸';

  @override
  String get aboutTipButton => 'Ti aiuterò.';

  @override
  String get aboutTipDesc => 'Voglio che Bloomee continui a migliorare.';

  @override
  String get aboutGitHub => 'GitHub';

  @override
  String get songInfoSectionDetails => 'Dettagli della canzone';

  @override
  String get songInfoSectionTechnical => 'Informazioni tecniche';

  @override
  String get songInfoSectionActions => 'Azioni';

  @override
  String get songInfoLabelTitle => 'Titolo';

  @override
  String get songInfoLabelArtist => 'Artista';

  @override
  String get songInfoLabelAlbum => 'Album';

  @override
  String get songInfoLabelDuration => 'Durata';

  @override
  String get songInfoLabelSource => 'Fonte';

  @override
  String get songInfoLabelMediaId => 'ID dei media';

  @override
  String get songInfoLabelPluginId => 'Plugin ID';

  @override
  String get songInfoIdCopied => 'Media ID copiato';

  @override
  String get songInfoLinkCopied => 'Link copiato';

  @override
  String get songInfoNoLink => 'No link disponibile';

  @override
  String get songInfoOpenFailed => 'Non si può aprire';

  @override
  String get songInfoUpdateMetadata => 'Ottieni i metadati più recenti';

  @override
  String get songInfoMetadataUpdated => 'Metadati aggiornati';

  @override
  String get songInfoMetadataUpdateFailed => 'Non è possibile aggiornare i metadati';

  @override
  String get songInfoMetadataUnavailable => 'Il rinfresco Metadata non è disponibile per questa fonte';

  @override
  String get songInfoSearchTitle => 'Cerca questa canzone in Bloomee';

  @override
  String get songInfoSearchArtist => 'Cerca per questo artista in Bloomee';

  @override
  String get songInfoSearchAlbum => 'Cerca questo album in Bloomee';

  @override
  String get eqTitle => 'Equalizzatore';

  @override
  String get eqResetTooltip => 'Ripristina su Flat';

  @override
  String get chartNoItems => 'Nessun elemento in questo grafico';

  @override
  String get chartLoadFailed => 'Non è riuscito a caricare il grafico';

  @override
  String get chartPlay => 'Gioca';

  @override
  String get chartResolving => 'Risolvere';

  @override
  String get chartReady => 'Pronti';

  @override
  String get chartAddToPlaylist => 'Aggiungi alla lista dei giochi';

  @override
  String get chartNoResolver => 'Nessun risolutore di contenuti caricato. Installa un plugin per giocare.';

  @override
  String get chartResolveFailed => 'Cercare invece...';

  @override
  String get chartNoResolverAdd => 'Nessun risolutore di contenuti caricato.';

  @override
  String get chartNoMatch => 'Non è possibile trovare una corrispondenza. Prova a cercare manualmente.';

  @override
  String get chartStatPeak => 'Peak';

  @override
  String get chartStatWeeks => 'Settimanali';

  @override
  String get chartStatChange => 'Cambiamento';

  @override
  String menuSharePreparing(String title) {
    return 'Preparazione di $title per la condivisione.';
  }

  @override
  String get menuOpenLinkFailed => 'Non si può aprire';

  @override
  String get localMusicFolders => 'Cartelle musicali';

  @override
  String get localMusicCloseSearch => 'Chiudi la ricerca';

  @override
  String get localMusicOpenSearch => 'Ricerca';

  @override
  String get localMusicNoMusicFound => 'Nessuna musica locale trovata';

  @override
  String get localMusicNoSearchResults => 'Nessuna traccia trovata in corrispondenza della tua ricerca.';

  @override
  String get importSongsTitle => 'Importare canzoni';

  @override
  String get importNoPluginsLoaded => 'Nessun content-importer plugin caricato. Installare un importatore plugin per importare playlists da servizi esterni.';

  @override
  String get importBloomeeFiles => 'Importa file Bloomee';

  @override
  String get importM3UFiles => 'Importazione M3U Playlist';

  @override
  String get importM3UNameDialogTitle => 'Nome della lista dei giochi';

  @override
  String get importM3UNameHint => 'Inserisci un nome per questo playlist';

  @override
  String get importM3UNoTracks => 'Nessuna traccia valida trovata nel file M3U.';

  @override
  String get importNoteTitle => 'Nota';

  @override
  String get importNoteMessage => 'È possibile importare solo i file creati da Bloomee. Se il file è da un\'altra fonte, non funzionerà.';

  @override
  String get importTitle => 'Importazioni';

  @override
  String get importCheckingUrl => 'Controllare l\'URL...';

  @override
  String get importFetchingTracks => 'Ritiro tracce...';

  @override
  String get importSavingToLibrary => 'Salvataggio in biblioteca...';

  @override
  String get importPasteUrlHint => 'Incolla a playlist o URL dell\'album per importare';

  @override
  String get importAction => 'Importazioni';

  @override
  String importTrackCount(int count) {
    return '$count tracce';
  }

  @override
  String get importResolving => 'Risolvere...';

  @override
  String importResolvingProgress(int done, int total) {
    return 'Risoluzione tracce: $done / $total';
  }

  @override
  String get importReviewTitle => 'Recensione dell\'importazione';

  @override
  String importReviewSummary(int resolved, int failed, int total) {
    return '$resolved risolte, $failed non riuscite su $total';
  }

  @override
  String importSaveTracks(int count) {
    return 'Salva $count tracce';
  }

  @override
  String importTracksSaved(int count) {
    return '$count tracce salvate!';
  }

  @override
  String get importDone => 'Fatto';

  @override
  String get importMore => 'Importazione di più';

  @override
  String get importUnknownError => 'Errore sconosciuto';

  @override
  String get importTryAgain => 'Prova di nuovo';

  @override
  String get importSkipTrack => 'Salta questa traccia';

  @override
  String get importMatchOptions => 'Opzioni di corrispondenza';

  @override
  String get importAutoMatched => 'Abbinato automaticamente';

  @override
  String get importUserSelected => 'Selezionato';

  @override
  String get importSkipped => 'Saltato';

  @override
  String get importNoMatch => 'Nessun risultato trovato';

  @override
  String get importReorderTip => 'Premere a lungo un playlist per iniziare a riordinare';

  @override
  String get importErrorCannotHandleUrl => 'Questo plugin non può gestire l\'URL fornito.';

  @override
  String get importErrorUnexpectedResponse => 'Risposta inaspettata da plugin.';

  @override
  String importErrorFailedToCheck(String error) {
    return 'Impossibile controllare l\'URL: $error';
  }

  @override
  String importErrorFailedToFetchInfo(String error) {
    return 'Impossibile recuperare le info della raccolta: $error';
  }

  @override
  String importErrorFailedToFetchTracks(String error) {
    return 'Impossibile recuperare le tracce: $error';
  }

  @override
  String importErrorFailedToSave(String error) {
    return 'Impossibile salvare la playlist: $error';
  }

  @override
  String get playlistPinToTop => 'Perno in cima';

  @override
  String get playlistUnpin => 'Rimuovi da in alto';

  @override
  String get snackbarImportingMedia => 'Importazione di MediaItems..';

  @override
  String get snackbarPlaylistSaved => 'Lista di riproduzione salvata in biblioteca!';

  @override
  String get snackbarInvalidFileFormat => 'Formato file non valido';

  @override
  String get snackbarMediaItemImported => 'Importazione dell\'oggetto media';

  @override
  String get snackbarPlaylistImported => 'Elenco di giochi Importato';

  @override
  String get snackbarOpenImportForUrl => 'Aprire la schermata Importa in Libreria per importare da questo URL.';

  @override
  String get snackbarProcessingFile => 'Elaborazione di file...';

  @override
  String snackbarPreparingShare(String title) {
    return 'Preparazione di $title per la condivisione';
  }

  @override
  String snackbarPreparingExport(String title) {
    return 'Preparazione di $title per l\'esportazione.';
  }

  @override
  String get pluginManagerTabInstalled => 'Installato';

  @override
  String get pluginManagerTabStore => 'Plugin Store';

  @override
  String get pluginManagerSelectPackage => 'Seleziona il pacchetto Plugin (.bex)';

  @override
  String get pluginManagerOutdatedManifest => 'Plugin utilizza una versione manifesta obsoleta. Alcune funzionalità potrebbero rompersi.';

  @override
  String get pluginManagerStatusActive => 'Attivo';

  @override
  String get pluginManagerStatusInactive => 'Inattivo';

  @override
  String pluginRepositoryUpdatedOn(String date) {
    return 'Aggiornato il $date';
  }

  @override
  String pluginRepositoryAvailableCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plugin disponibili',
      one: '1 plugin disponibile',
    );
    return '$_temp0';
  }

  @override
  String get pluginRepositoryOutdatedManifest => 'manifesto obsoleto. Le funzioni possono rompersi.';

  @override
  String get pluginRepositoryUnknownPublisher => 'Editore sconosciuto';

  @override
  String get pluginRepositoryActionRetry => 'Recuperare';

  @override
  String get pluginRepositoryActionOutdated => 'Esterno';

  @override
  String get pluginRepositoryActionInstalled => 'Installato';

  @override
  String get pluginRepositoryActionInstall => 'Installazione';

  @override
  String get pluginRepositoryActionUnavailable => 'Non disponibile';

  @override
  String get pluginRepositoryInstallFailed => 'L\'installazione è fallita.';

  @override
  String pluginRepositoryDownloadFailed(String name) {
    return 'Impossibile scaricare $name.';
  }

  @override
  String smartReplaceAppliedPlaylistsSummary(int count, String queue) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sostituito in $count playlist$queue.',
      one: 'Sostituito in 1 playlist$queue.',
    );
    return '$_temp0';
  }

  @override
  String get lyricsSearchFieldLabel => 'Cerca i testi...';

  @override
  String get lyricsSearchEmptyPrompt => 'Digitare una canzone o un artista per trovare testi.';

  @override
  String lyricsSearchNoResults(String query) {
    return 'Nessun testo trovato per "$query"';
  }

  @override
  String get lyricsSearchApplied => 'Lirica applicata con successo';

  @override
  String get lyricsSearchFetchFailed => 'Non sono riuscito a recuperare i testi';

  @override
  String get lyricsSearchPreview => 'Anteprima';

  @override
  String get lyricsSearchPreviewTooltip => 'Anteprima dei testi';

  @override
  String get lyricsSearchSynced => 'SINCRONIZZATO';

  @override
  String get lyricsSearchPreviewLoadFailed => 'Non sono riuscito a caricare i testi.';

  @override
  String get lyricsSearchApplyAction => 'Applicare i testi';

  @override
  String get lyricsSettingsSearchTitle => 'Ricerca di testi personalizzati';

  @override
  String get lyricsSettingsSearchSubtitle => 'Trova le versioni alternative online';

  @override
  String get lyricsSettingsSyncTitle => 'Regolare la sincronizzazione (disporre / disattivare)';

  @override
  String get lyricsSettingsSyncSubtitle => 'Fissare i testi che sono troppo veloci o lenti';

  @override
  String get lyricsSettingsSaveTitle => 'Salvare Offline';

  @override
  String get lyricsSettingsSaveSubtitle => 'Memorizza questi testi sul tuo dispositivo';

  @override
  String get lyricsSettingsDeleteTitle => 'Eliminare i testi salvati';

  @override
  String get lyricsSettingsDeleteSubtitle => 'Rimuovere i dati dei testi offline';

  @override
  String get lyricsSyncTapToReset => 'Toccare per ripristinare';

  @override
  String get upNextTitle => 'Il prossimo';

  @override
  String upNextItemsInQueue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementi in coda',
      one: '1 elemento in coda',
    );
    return '$_temp0';
  }

  @override
  String get upNextAutoPlay => 'Riproduzione automatica';

  @override
  String get tooltipCopyToClipboard => 'Copia a clipboard';

  @override
  String get snackbarCopiedToClipboard => 'Copiato negli appunti';

  @override
  String get tooltipSongInfo => 'Informazioni sulla canzone';

  @override
  String get snackbarCannotDeletePlayingSong => 'Impossibile eliminare il brano attualmente in riproduzione';

  @override
  String get playerLoopOff => 'Disattivato';

  @override
  String get playerLoopOne => 'Loop One';

  @override
  String get playerLoopAll => 'Loop Tutti';

  @override
  String get snackbarOpeningAlbumPage => 'Apertura pagina originale dell\'album.';

  @override
  String updateAvailableBody(String ver, String build) {
    return 'La nuova versione di Bloomee🌸 è ora disponibile!\n\nVersione: $ver+$build';
  }

  @override
  String pluginSnackbarInstalled(String id) {
    return 'Plugin "$id" installato con successo';
  }

  @override
  String pluginSnackbarLoaded(String id) {
    return 'Plugin "$id" caricato';
  }

  @override
  String pluginSnackbarDeleted(String id) {
    return 'Plugin "$id" eliminato con successo';
  }

  @override
  String get pluginBootstrapTitle => 'Impostazione di Bloomee';

  @override
  String pluginBootstrapProgress(int percent) {
    return 'Configurazione del nuovo motore plugin... $percent%';
  }

  @override
  String get pluginBootstrapHint => 'Succede solo una volta.';

  @override
  String get pluginBootstrapErrorTitle => 'Connessione troppo lenta';

  @override
  String get pluginBootstrapErrorBody => 'Alcuni plugin non potrebbero essere installati. È ancora possibile utilizzare Bloomee — plugin sarà riattivato il prossimo lancio.';

  @override
  String get pluginBootstrapContinue => 'Continuare';
