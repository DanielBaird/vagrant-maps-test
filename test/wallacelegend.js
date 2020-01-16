L.Control.Legend = L.Control.extend({

	includes: L.Evented,

	options: {
		position: 'bottomleft',
		uri: null
	},

	initialize: function (options) {
		L.Util.setOptions(this, options)
		for (var i in this) {
			if (typeof(i) === 'string' && i.indexOf('initialize_') === 0)
				this[i]()
		}
	},

	onAdd: function (map) {
		this._container = L.DomUtil.create('div', 'leaflet-control-attribution')
		L.DomEvent.disableClickPropagation(this._container)

		this._map = map
		this._legend = L.DomUtil.create('img', null, this._container)
		this._legend.setAttribute('src', this.options.uri)

		// this.fire('add', {map: map});

		return this._container;
	}


});