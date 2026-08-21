import QtQuick.Layouts
import qs.config
import qs.components
import qs.services

ColumnLayout {
    spacing: Tokens.spacing.largeIncreased

    StyledText {
        text: qsTr("Bar")
        font: Tokens.font.title.large
    }

    SettingsGroup {
        Layout.fillWidth: true

        SettingsToggleRow {
            icon: "push_pin"
            label: qsTr("Bar always visible")
            checked: Settings.barPersistent
            onToggled: state => Settings.barPersistent = state
        }

        SettingsToggleRow {
            icon: "dock_to_right"
            label: qsTr("Dock bar to right edge")
            checked: Settings.barPositionRight
            onToggled: state => Settings.barPositionRight = state
        }

        SettingsToggleRow {
            icon: "density_small"
            label: qsTr("Compact bar")
            checked: Settings.barCompact
            onToggled: state => Settings.barCompact = state
        }

        // Vertical bar orientation isn't built yet (roadmap Feature #5) --
        // this is a different feature than barPositionRight above (which
        // only docks a still-horizontal bar to the other edge). Shown
        // disabled rather than omitted so the eventual feature has an
        // obvious home instead of needing a new row added later.
        SettingsToggleRow {
            enabled: false
            opacity: 0.4
            icon: "swap_horiz"
            label: qsTr("Vertical orientation (coming soon)")
            checked: false
            onToggled: state => {}
        }
    }
}
