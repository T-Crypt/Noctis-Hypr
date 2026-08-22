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
            visible: !Settings.barVertical
            icon: "dock_to_right"
            label: qsTr("Dock bar to right edge")
            checked: Settings.barPositionRight
            onToggled: state => Settings.barPositionRight = state
        }

        SettingsToggleRow {
            visible: Settings.barVertical
            icon: "vertical_align_bottom"
            label: qsTr("Dock bar to bottom edge")
            checked: Settings.barPositionBottom
            onToggled: state => Settings.barPositionBottom = state
        }

        SettingsToggleRow {
            icon: "density_small"
            label: qsTr("Compact bar")
            checked: Settings.barCompact
            onToggled: state => Settings.barCompact = state
        }

        // Roadmap Feature #5 -- a real second orientation (top/bottom
        // dock, full width, entries flowing left-to-right) alongside the
        // left/right-docked, top-to-bottom mode above.
        SettingsToggleRow {
            icon: "swap_horiz"
            label: qsTr("Vertical orientation")
            checked: Settings.barVertical
            onToggled: state => Settings.barVertical = state
        }
    }
}
