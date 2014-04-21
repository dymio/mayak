/*!
 *  Popapilus v.0.9 - 2013-10-03
 *  jQuery plugin for creating popups: modal windows, hints etc.
 *  http://github.com/dymio/popapilus
 *  (c) 2013 Ivan Dymkov ( http://dymio.net , @dymio )
 *  license: http://www.opensource.org/licenses/mit-license.php
 *
 *  requires jQuery 1.7.1 or higher
 */

(function ( $, document, window ) {

  // Plugin bridge
  $.popapilus = function( options ) {
    var opts = $.extend( {}, $.popapilus.defaults, options );
    return new Popapilus( opts );
  };

  // Plugin defaults
  $.popapilus.defaults = {
    css_class: 'popapilus', // can't change after init

    no_overlay:                   false,               // can't change after init
    overlay_css_class:            'popapilus_overlay', // can't change after init
    overlay_z_index:              3998,                // can't change after init
    overlay_show_animation_speed: 0,
    close_on_overlay_click:       true,

    fixed:    true,  // fixed or absolute position of block
    z_index:  3999,
    modal:    true,  // works only if no_overlay == false
    centered: true,  // always works by x axis but by y axis only if fixed
    top:      null,  // don't works if centered && fixed
    right:    null,  // works if not centered
    bottom:   null,  // don't works if centered && fixed
    left:     null,  // works if not centered
    width:    null,
    height:   null,

    ignore_close_btn: false,
    show_animation_speed: 0,
    autoclose_time: 0
  };

  /** Overlay worker **/
  function PopapilusOverlay( options ) {
    var self = this;

    var overlay = null;
    var _is_visible = false;

    this.onClickFunction = null;

    this.show = function( show_options ) {
      if ( _is_visible ) return false;
      var opts = $.extend( {}, options, show_options );
      overlay.fadeIn( opts.overlay_show_animation_speed );
      _is_visible = true;
    }

    this.hide = function() {
      if ( !_is_visible ) return false;
      overlay.hide();
      _is_visible = false;
    }

    this.init = function() {
      $("body").append('<div class="' + options.overlay_css_class + '"></div>');

      overlay = $("body ." + options.overlay_css_class + ":last");
      
      overlay.css({
        display:  'none',
        position: 'fixed',
        top:  0,
        left: 0,
        width:  '100%',
        height: '100%',
        'z-index': options.overlay_z_index
      });

      overlay.click(function(evnt) {
        evnt.preventDefault();
        if (self.onClickFunction) self.onClickFunction( evnt );
      });
    }

    this.init();
  }

  /** Main worker**/
  function Popapilus( options ) {
    var self = this;

    var overlay = null;
    var holder = null;

    var _is_visible = false;
    var _session_opts = {};

    this.__defineGetter__("isVisible", function() { return _is_visible; });

    function setHolderStyles() {
      var opts = _session_opts;
      holder.attr('style', 'display: none;'); // flush old styles

      holder.css({
        position: opts.fixed ? 'fixed' : 'absolute',
        'z-index': opts.z_index
      });

      if (opts.width !== null)  holder.css('width',  opts.width);
      if (opts.height !== null) holder.css('height', opts.height);

      if (!(opts.centered && opts.fixed)) {
        if (opts.top !== null)    holder.css('top',    opts.top);
        if (opts.bottom !== null) holder.css('bottom', opts.bottom);
      }

      if (!opts.centered) {
        if (opts.right !== null) holder.css('right', opts.right);
        if (opts.left !== null)  holder.css('left',  opts.left);
      }

      if (holder.css('top') === "auto") { holder.css('top', 0); }
    }

    function centerHolder() {
      holder.css('left', Math.max(0, ($(window).width() / 2) - (holder.width() / 2)).toString() + 'px' ); // by x axis

      if (_session_opts.fixed)
        holder.css('top', Math.max(0, ($(window).height() / 2) - (holder.height() / 2)).toString() + 'px' ); // by y axis if position is 'fixed'
    }

    function _close() {
      self.hide();
    }

    function inactivate() {
      $(window).off('resize', centerHolder);
      if (overlay) overlay.onClickFunction = null;
      holder.find(".close").off('click', _close);
    }

    function fillWithData( data ) {
      holder.empty();
      holder.append(data);
    }

    function _showOverlay() {
      if (_session_opts.modal && overlay) { overlay.show(_session_opts); }
    }

    this.show = function( data, show_options ) {
      _session_opts = $.extend( {}, options, show_options );

      if (_is_visible) {  inactivate(); }

      if (data) { fillWithData( data ); }

      if (!_session_opts.ignore_close_btn) {
        holder.find(".close").on('click', _close);
      }

      setHolderStyles();

      if (_session_opts.close_on_overlay_click && overlay) {
        overlay.onClickFunction = function(evnt) { self.hide(); }
      }

      _showOverlay();

      if (_session_opts.centered) {
        $(window).on('resize', centerHolder);
        centerHolder();
      }

      if (!_is_visible) { holder.fadeIn(_session_opts.show_animation_speed); }

      _is_visible = true;

      if (_session_opts.autoclose_time) {
        setTimeout(function() { self.hide(); }, _session_opts.autoclose_time);
      }
    }

    this.showOverlay = function( show_options ) {
      _session_opts = $.extend( {}, options, show_options );
      _showOverlay();
    }

    this.setData = function( data ) {
      if (data) { fillWithData( data ); }
    }

    this.hide = function() {
      inactivate();
      holder.hide();
      if (overlay) overlay.hide();
      _is_visible = false;
      _session_option = options;
    }

    /* 
     * Initialize function
     */
    function _init() {
      if (!options.no_overlay) { overlay = new PopapilusOverlay(options); }
      
      // create a popapilus DOM block
      $("body").append('<div class="' + options.css_class + '"></div>');
      holder = $("body ." + options.css_class + ":last");

      self.hide();
      setHolderStyles();
    }

    // rock'n'roll
    _init();
  }

}( jQuery, document, window ));